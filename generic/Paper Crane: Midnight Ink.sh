#!/bin/sh
# Paper Crane: Midnight Ink

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
put_template 0  "30/3a/3c"
put_template 1  "b9/68/5c"
put_template 2  "7d/9e/85"
put_template 3  "c1/a0/6b"
put_template 4  "81/9c/bd"
put_template 5  "aa/88/a7"
put_template 6  "79/a9/a5"
put_template 7  "d4/d3/c9"
put_template 8  "60/70/73"
put_template 9  "dc/89/77"
put_template 10 "a2/c2/a4"
put_template 11 "df/c0/8b"
put_template 12 "a5/bb/db"
put_template 13 "c7/a9/c4"
put_template 14 "a1/d0/c8"
put_template 15 "ff/f8/e8"

color_foreground="e6/e2/d6"
color_background="20/27/2a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e2d6"
  put_template_custom Ph "20272a"
  put_template_custom Pi "e6e2d6"
  put_template_custom Pj "3c4b49"
  put_template_custom Pk "6c7376"
  put_template_custom Pl "d9826b"
  put_template_custom Pm "20272a"
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
