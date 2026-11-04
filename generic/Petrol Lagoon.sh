#!/bin/sh
# Petrol Lagoon

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
put_template 0  "15/23/25"
put_template 1  "e0/73/6e"
put_template 2  "6c/c4/8e"
put_template 3  "d1/b3/66"
put_template 4  "5b/9f/c4"
put_template 5  "9d/8c/cc"
put_template 6  "3f/c4/b7"
put_template 7  "a0/b8/b8"
put_template 8  "4d/64/67"
put_template 9  "ec/8f/88"
put_template 10 "8a/da/a8"
put_template 11 "e2/c9/85"
put_template 12 "7d/b8/d8"
put_template 13 "b5/a7/dd"
put_template 14 "66/d9/cd"
put_template 15 "df/ee/ee"

color_foreground="c2/d8/d8"
color_background="0c/16/18"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c2d8d8"
  put_template_custom Ph "0c1618"
  put_template_custom Pi "c2d8d8"
  put_template_custom Pj "17393d"
  put_template_custom Pk "dfeeee"
  put_template_custom Pl "35d0c0"
  put_template_custom Pm "0c1618"
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
