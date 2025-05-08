#!/bin/sh
# Blazer

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
put_template 1  "b8/7a/7a"
put_template 2  "7a/b8/7a"
put_template 3  "b8/b8/7a"
put_template 4  "7a/7a/b8"
put_template 5  "b8/7a/b8"
put_template 6  "7a/b8/b8"
put_template 7  "d9/d9/d9"
put_template 8  "26/26/26"
put_template 9  "db/bd/bd"
put_template 10 "bd/db/bd"
put_template 11 "db/db/bd"
put_template 12 "bd/bd/db"
put_template 13 "db/bd/db"
put_template 14 "bd/db/db"
put_template 15 "ff/ff/ff"

color_foreground="d9/e6/f2"
color_background="0d/19/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d9e6f2"
  put_template_custom Ph "0d1926"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "c1ddff"
  put_template_custom Pk "000000"
  put_template_custom Pl "d9e6f2"
  put_template_custom Pm "0d1926"
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
