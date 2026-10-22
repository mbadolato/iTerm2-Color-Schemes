#!/bin/sh
# Lumina Nebula Dark

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "0e/15/20"
put_template 1  "d3/60/59"
put_template 2  "8b/ce/99"
put_template 3  "f7/cf/55"
put_template 4  "92/be/f8"
put_template 5  "e3/a2/dc"
put_template 6  "00/df/e5"
put_template 7  "aa/bc/ca"
put_template 8  "72/82/95"
put_template 9  "df/84/7d"
put_template 10 "a3/e9/b2"
put_template 11 "ff/e6/a0"
put_template 12 "ba/d7/ff"
put_template 13 "ff/bb/f7"
put_template 14 "8f/f1/f4"
put_template 15 "ca/dc/eb"

color_foreground="ca/dc/eb"
color_background="0a/11/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cadceb"
  put_template_custom Ph "0a111a"
  put_template_custom Pi "cadceb"
  put_template_custom Pj "163c45"
  put_template_custom Pk "cadceb"
  put_template_custom Pl "cadceb"
  put_template_custom Pm "0a111a"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
