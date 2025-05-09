#!/bin/sh
# Dimidium

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
put_template 1  "cf/49/4c"
put_template 2  "60/b4/42"
put_template 3  "db/9c/11"
put_template 4  "05/75/d8"
put_template 5  "af/5e/d2"
put_template 6  "1d/b6/bb"
put_template 7  "ba/b7/b6"
put_template 8  "81/7e/7e"
put_template 9  "ff/64/3b"
put_template 10 "37/e5/7b"
put_template 11 "fc/cd/1a"
put_template 12 "68/8d/fd"
put_template 13 "ed/6f/e9"
put_template 14 "32/e0/fb"
put_template 15 "d3/d8/d9"

color_foreground="ba/b7/b6"
color_background="14/14/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "bab7b6"
  put_template_custom Ph "141414"
  put_template_custom Pi "d3d8d9"
  put_template_custom Pj "8db8e5"
  put_template_custom Pk "141414"
  put_template_custom Pl "37e57b"
  put_template_custom Pm "141414"
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
