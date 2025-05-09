#!/bin/sh
# Atom

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
put_template 1  "fd/5f/f1"
put_template 2  "87/c3/8a"
put_template 3  "ff/d7/b1"
put_template 4  "85/be/fd"
put_template 5  "b9/b6/fc"
put_template 6  "85/be/fd"
put_template 7  "e0/e0/e0"
put_template 8  "00/00/00"
put_template 9  "fd/5f/f1"
put_template 10 "94/fa/36"
put_template 11 "f5/ff/a8"
put_template 12 "96/cb/fe"
put_template 13 "b9/b6/fc"
put_template 14 "85/be/fd"
put_template 15 "e0/e0/e0"

color_foreground="c5/c8/c6"
color_background="16/17/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c5c8c6"
  put_template_custom Ph "161719"
  put_template_custom Pi "c5c8c6"
  put_template_custom Pj "444444"
  put_template_custom Pk "c5c8c6"
  put_template_custom Pl "d0d0d0"
  put_template_custom Pm "151515"
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
