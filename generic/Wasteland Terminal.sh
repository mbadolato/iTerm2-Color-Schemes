#!/bin/sh
# Wasteland Terminal

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
put_template 0  "05/0b/05"
put_template 1  "26/b3/4f"
put_template 2  "18/ff/62"
put_template 3  "a1/d6/4b"
put_template 4  "3e/9b/67"
put_template 5  "64/b8/79"
put_template 6  "60/e8/99"
put_template 7  "b5/ff/c5"
put_template 8  "2c/6b/3f"
put_template 9  "3f/d0/68"
put_template 10 "5c/ff/8f"
put_template 11 "c4/ee/70"
put_template 12 "56/bd/84"
put_template 13 "84/d6/9a"
put_template 14 "8c/f5/b8"
put_template 15 "e0/ff/e6"

color_foreground="18/ff/62"
color_background="05/0b/05"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "18ff62"
  put_template_custom Ph "050b05"
  put_template_custom Pi "18ff62"
  put_template_custom Pj "1a4d27"
  put_template_custom Pk "e0ffe6"
  put_template_custom Pl "39ff72"
  put_template_custom Pm "050b05"
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
