#!/bin/sh
# Daybreaker

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
put_template 0  "29/29/29"
put_template 1  "9f/17/17"
put_template 2  "07/55/23"
put_template 3  "59/43/00"
put_template 4  "14/52/ad"
put_template 5  "6f/2d/9b"
put_template 6  "00/50/64"
put_template 7  "3d/3d/3d"
put_template 8  "55/55/55"
put_template 9  "a9/1e/1e"
put_template 10 "07/59/23"
put_template 11 "5d/47/00"
put_template 12 "16/47/8f"
put_template 13 "74/34/a1"
put_template 14 "00/53/69"
put_template 15 "48/48/48"

color_foreground="1e/1e/1e"
color_background="ff/fa/f6"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1e1e1e"
  put_template_custom Ph "fffaf6"
  put_template_custom Pi "8f3600"
  put_template_custom Pj "e5e1d8"
  put_template_custom Pk "1e1e1e"
  put_template_custom Pl "8a4b00"
  put_template_custom Pm "fffaf6"
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
