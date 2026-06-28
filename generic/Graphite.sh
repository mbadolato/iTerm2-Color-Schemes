#!/bin/sh
# Graphite

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
put_template 0  "15/17/1a"
put_template 1  "e5/88/88"
put_template 2  "a7/c5/9f"
put_template 3  "ce/c5/9d"
put_template 4  "8d/b4/d0"
put_template 5  "ba/ab/cb"
put_template 6  "a8/c6/d4"
put_template 7  "b4/b9/c0"
put_template 8  "7e/85/90"
put_template 9  "f1/9f/9f"
put_template 10 "b9/d5/b1"
put_template 11 "cf/ba/97"
put_template 12 "a5/c6/de"
put_template 13 "cc/be/dd"
put_template 14 "bc/d6/e2"
put_template 15 "ec/ef/f3"

color_foreground="d2/d6/dc"
color_background="1c/1e/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d2d6dc"
  put_template_custom Ph "1c1e22"
  put_template_custom Pi "d2d6dc"
  put_template_custom Pj "2e333b"
  put_template_custom Pk "5c5e62"
  put_template_custom Pl "c4cedb"
  put_template_custom Pm "1c1e22"
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
