#!/bin/sh
# Undead

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
put_template 0  "c0/bd/9f"
put_template 1  "e6/9a/72"
put_template 2  "a8/c9/7c"
put_template 3  "d9/c1/64"
put_template 4  "91/bd/b5"
put_template 5  "bd/9e/b0"
put_template 6  "83/c5/b5"
put_template 7  "f3/ed/cf"
put_template 8  "d1/ce/b2"
put_template 9  "ec/ae/8b"
put_template 10 "ba/d5/98"
put_template 11 "e4/d1/81"
put_template 12 "a8/cc/c4"
put_template 13 "cd/b6/c1"
put_template 14 "9d/d4/c7"
put_template 15 "ff/f8/e5"

color_foreground="f3/ed/cf"
color_background="3d/3c/1c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f3edcf"
  put_template_custom Ph "3d3c1c"
  put_template_custom Pi "d6cd68"
  put_template_custom Pj "5d5c37"
  put_template_custom Pk "fff8e3"
  put_template_custom Pl "ded157"
  put_template_custom Pm "3d3c1c"
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
