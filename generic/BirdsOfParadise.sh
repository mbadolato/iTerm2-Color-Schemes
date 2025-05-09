#!/bin/sh
# BirdsOfParadise

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
put_template 0  "57/3d/26"
put_template 1  "be/2d/26"
put_template 2  "6b/a1/8a"
put_template 3  "e9/9d/2a"
put_template 4  "5a/86/ad"
put_template 5  "ac/80/a6"
put_template 6  "74/a6/ad"
put_template 7  "e0/db/b7"
put_template 8  "9b/6c/4a"
put_template 9  "e8/46/27"
put_template 10 "95/d8/ba"
put_template 11 "d0/d1/50"
put_template 12 "b8/d3/ed"
put_template 13 "d1/9e/cb"
put_template 14 "93/cf/d7"
put_template 15 "ff/f9/d5"

color_foreground="e0/db/b7"
color_background="2a/1f/1d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0dbb7"
  put_template_custom Ph "2a1f1d"
  put_template_custom Pi "fff8d8"
  put_template_custom Pj "563c27"
  put_template_custom Pk "e0dbbb"
  put_template_custom Pl "573d26"
  put_template_custom Pm "573d26"
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
