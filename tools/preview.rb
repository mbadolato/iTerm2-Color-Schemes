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
char_input = ''
moving_forward = true
file_stack = []
file_stack_back = []
until files.empty?
  if char_input == 'b' and file_stack.size != 0
      if moving_forward
        file_stack_back.push(file_stack.pop)
      end
      moving_forward = false
      file = file_stack.pop
      file_stack_back.push(file)
    elsif file_stack_back.size != 0
        if not(moving_forward)
            file_stack.push(file_stack_back.pop)
        end
        moving_forward = true
        file = file_stack_back.pop
        file_stack.push(file)
  else
    moving_forward = true
    file = files.shift
    file_stack.push(file)
  end
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
    char_input = IO.console.getch
    break if files.empty? || [3.chr, "\e"].include?(char_input)
  rescue Exception
    print '(X) '
  end
end
puts if preview

