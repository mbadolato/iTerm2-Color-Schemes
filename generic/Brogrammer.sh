#!/bin/sh
# Brogrammer

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
put_template 0  "1f/1f/1f"
put_template 1  "f8/11/18"
put_template 2  "2d/c5/5e"
put_template 3  "ec/ba/0f"
put_template 4  "2a/84/d2"
put_template 5  "4e/5a/b7"
put_template 6  "10/81/d6"
put_template 7  "d6/db/e5"
put_template 8  "d6/db/e5"
put_template 9  "de/35/2e"
put_template 10 "1d/d3/61"
put_template 11 "f3/bd/09"
put_template 12 "10/81/d6"
put_template 13 "53/50/b9"
put_template 14 "0f/7d/db"
put_template 15 "ff/ff/ff"

color_foreground="d6/db/e5"
color_background="13/13/13"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d6dbe5"
  put_template_custom Ph "131313"
  put_template_custom Pi "d6dbe5"
  put_template_custom Pj "1f1f1f"
  put_template_custom Pk "d6dbe5"
  put_template_custom Pl "b9b9b9"
  put_template_custom Pm "101010"
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
