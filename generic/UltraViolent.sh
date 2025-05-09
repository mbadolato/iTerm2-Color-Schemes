#!/bin/sh
# UltraViolent

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
put_template 0  "24/27/28"
put_template 1  "ff/00/90"
put_template 2  "b6/ff/00"
put_template 3  "ff/f7/27"
put_template 4  "47/e0/fb"
put_template 5  "d7/31/ff"
put_template 6  "0e/ff/bb"
put_template 7  "e1/e1/e1"
put_template 8  "63/66/67"
put_template 9  "fb/58/b4"
put_template 10 "de/ff/8c"
put_template 11 "eb/e0/87"
put_template 12 "7f/ec/ff"
put_template 13 "e6/81/ff"
put_template 14 "69/fc/d3"
put_template 15 "f9/f9/f5"

color_foreground="c1/c1/c1"
color_background="24/27/28"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c1c1c1"
  put_template_custom Ph "242728"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "574c49"
  put_template_custom Pk "c3c7cb"
  put_template_custom Pl "c1c1c1"
  put_template_custom Pm "ffffff"
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
