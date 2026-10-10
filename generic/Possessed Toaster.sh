#!/bin/sh
# Possessed Toaster

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
put_template 0  "a9/aa/a3"
put_template 1  "e0/50/3b"
put_template 2  "6a/a8/4f"
put_template 3  "e0/a6/2e"
put_template 4  "3d/9a/ff"
put_template 5  "a8/55/f7"
put_template 6  "2d/d4/bf"
put_template 7  "e8/dc/c0"
put_template 8  "c2/c3/bd"
put_template 9  "ff/5a/3c"
put_template 10 "9e/db/6f"
put_template 11 "f4/ca/4d"
put_template 12 "60/b5/ff"
put_template 13 "c0/84/fc"
put_template 14 "4e/e6/d3"
put_template 15 "ff/f5/d7"

color_foreground="e8/dc/c0"
color_background="0e/0f/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8dcc0"
  put_template_custom Ph "0e0f0d"
  put_template_custom Pi "f4ca4d"
  put_template_custom Pj "3a3f3a"
  put_template_custom Pk "fff5da"
  put_template_custom Pl "f4ca4d"
  put_template_custom Pm "0e0f0d"
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
