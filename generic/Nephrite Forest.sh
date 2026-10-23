#!/bin/sh
# Nephrite Forest

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
put_template 0  "25/34/2c"
put_template 1  "ff/a0/9c"
put_template 2  "4d/bf/74"
put_template 3  "d9/bb/5c"
put_template 4  "89/c3/fe"
put_template 5  "d0/aa/fc"
put_template 6  "43/d5/dc"
put_template 7  "b4/c1/ba"
put_template 8  "76/84/7c"
put_template 9  "ff/a0/9c"
put_template 10 "5e/d7/b5"
put_template 11 "d9/bb/5c"
put_template 12 "89/c3/fe"
put_template 13 "f9/9d/c6"
put_template 14 "43/d5/dc"
put_template 15 "e0/eb/e5"

color_foreground="e0/eb/e5"
color_background="0d/1c/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0ebe5"
  put_template_custom Ph "0d1c14"
  put_template_custom Pi "e0ebe5"
  put_template_custom Pj "324139"
  put_template_custom Pk "e0ebe5"
  put_template_custom Pl "4dbf74"
  put_template_custom Pm "0d1c14"
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
