#!/bin/sh
# Spring

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
put_template 0  "00/00/00"
put_template 1  "ff/4d/83"
put_template 2  "1f/8c/3b"
put_template 3  "1f/c9/5b"
put_template 4  "1d/d3/ee"
put_template 5  "89/59/a8"
put_template 6  "3e/99/9f"
put_template 7  "ff/ff/ff"
put_template 8  "00/00/00"
put_template 9  "ff/00/21"
put_template 10 "1f/c2/31"
put_template 11 "d5/b8/07"
put_template 12 "15/a9/fd"
put_template 13 "89/59/a8"
put_template 14 "3e/99/9f"
put_template 15 "ff/ff/ff"

color_foreground="4d/4d/4c"
color_background="ff/ff/ff"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "4d4d4c"
  put_template_custom Ph "ffffff"
  put_template_custom Pi "4d4d4c"
  put_template_custom Pj "d6d6d6"
  put_template_custom Pk "4d4d4c"
  put_template_custom Pl "4d4d4c"
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
