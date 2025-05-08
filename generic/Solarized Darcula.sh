#!/bin/sh
# Solarized Darcula

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
put_template 0  "25/29/2a"
put_template 1  "f2/48/40"
put_template 2  "62/96/55"
put_template 3  "b6/88/00"
put_template 4  "20/75/c7"
put_template 5  "79/7f/d4"
put_template 6  "15/96/8d"
put_template 7  "d2/d8/d9"
put_template 8  "25/29/2a"
put_template 9  "f2/48/40"
put_template 10 "62/96/55"
put_template 11 "b6/88/00"
put_template 12 "20/75/c7"
put_template 13 "79/7f/d4"
put_template 14 "15/96/8d"
put_template 15 "d2/d8/d9"

color_foreground="d2/d8/d9"
color_background="3d/3f/41"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d2d8d9"
  put_template_custom Ph "3d3f41"
  put_template_custom Pi "ececec"
  put_template_custom Pj "214283"
  put_template_custom Pk "d2d8d9"
  put_template_custom Pl "708284"
  put_template_custom Pm "002831"
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
