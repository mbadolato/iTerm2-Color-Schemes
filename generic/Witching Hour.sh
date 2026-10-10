#!/bin/sh
# Witching Hour

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
put_template 0  "b9/ae/c8"
put_template 1  "f1/8a/9d"
put_template 2  "a4/d6/6e"
put_template 3  "e9/c8/6b"
put_template 4  "91/c4/ed"
put_template 5  "c9/95/f0"
put_template 6  "80/d4/d2"
put_template 7  "f5/ed/ff"
put_template 8  "ce/c3/dc"
put_template 9  "f5/a6/b4"
put_template 10 "ba/e1/87"
put_template 11 "f1/d9/8a"
put_template 12 "ad/d5/f3"
put_template 13 "d9/b1/f5"
put_template 14 "a0/e1/df"
put_template 15 "ff/fa/ff"

color_foreground="f5/ed/ff"
color_background="26/10/44"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5edff"
  put_template_custom Ph "261044"
  put_template_custom Pi "c894ff"
  put_template_custom Pj "45236b"
  put_template_custom Pk "fff8ff"
  put_template_custom Pl "b56cff"
  put_template_custom Pm "261044"
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
