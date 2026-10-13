#!/bin/sh
# Unalive 'Em All

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
put_template 0  "aa/a2/9e"
put_template 1  "ec/51/4a"
put_template 2  "81/bb/7a"
put_template 3  "e7/b7/5d"
put_template 4  "78/ae/f0"
put_template 5  "c6/8b/d8"
put_template 6  "68/c7/c7"
put_template 7  "ee/e3/dd"
put_template 8  "c6/be/ba"
put_template 9  "ff/79/71"
put_template 10 "a1/d3/91"
put_template 11 "f5/ce/77"
put_template 12 "96/c3/fa"
put_template 13 "db/a8/e9"
put_template 14 "87/db/d9"
put_template 15 "ff/f5/ed"

color_foreground="ee/e3/dd"
color_background="11/0c/0b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eee3dd"
  put_template_custom Ph "110c0b"
  put_template_custom Pi "fff4e8"
  put_template_custom Pj "3f2223"
  put_template_custom Pk "fff4e8"
  put_template_custom Pl "ff4541"
  put_template_custom Pm "110c0b"
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
