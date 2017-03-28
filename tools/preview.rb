#!/usr/bin/ruby
#
# Applies the colors defined in .itermcolors file to the current session using
# proprietary escape codes of iTerm2
#
# Author: Junegunn Choi <https://github.com/junegunn> Reference:
# https://iterm2.com/documentation-escape-codes.html

require 'rexml/document'
require 'io/console'

files = ARGV.select { |f| File.exists? f }
if files.empty?
  puts "usage: #$0 <itermcolors files...>"
  exit 1
end

if ENV.has_key? 'TMUX'
  puts 'Does not work on tmux'
  exit 1
end

preview = files.length > 1
history = []
until files.empty?
  file = files.shift
  print "[#{File.basename file, '.*'}] " if preview
  begin
    colors = {}
    root = REXML::Document.new(File.read file).root
    root.elements['dict'].select { |e| e.is_a? REXML::Element }.each do |dict|
      if dict.previous_element && !dict.previous_element.text.strip.empty?
        type = dict.previous_element.text.downcase.gsub(/^ansi\s+|\s+color$/, '')
        colors[type] = {}
      end
      next unless type

      dict.elements.each_slice(2) do |elems|
        key = val = nil
        elems.each do |elem|
          case elem.name.downcase
          when 'key'  then key = elem.text
          when 'real' then val = elem.text
          end
        end
        colors[type][key.sub(/\s.+/, '').downcase.to_sym] =
          '%02x' % [255, val.to_f.*(256).to_i].min if key && val
      end
      colors[type] &&= colors[type].values_at(:red, :green, :blue).join
    end

    colors.each do |type, rgb|
      print "\e]P" << {
        'foreground'    => 'g',
        'background'    => 'h',
        'bold'          => 'i',
        'selection'     => 'j',
        'selected text' => 'k',
        'cursor'        => 'l',
        'cursor text'   => 'm',
      }.fetch(type, '%x' % type.to_i) << rgb << "\e\\"
    end
    case IO.console.getch.ord
    when 127   # backspace
      files.unshift *[history.pop, file].compact
    when 3, 27 # ctrl-c, esc
      break
    else
      history << file
    end
  rescue Exception
    print '(X) '
  end
end
puts if preview

