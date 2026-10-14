#!/bin/sh
# Sunset Copper Relay

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
put_template 0  "21/1c/1b"
put_template 1  "e7/8c/80"
put_template 2  "a5/c9/94"
put_template 3  "e8/c0/7c"
put_template 4  "91/bb/d9"
put_template 5  "c8/a7/dc"
put_template 6  "86/cb/c0"
put_template 7  "e9/dd/cf"
put_template 8  "76/62/5d"
put_template 9  "ff/ae/9d"
put_template 10 "c4/dd/a8"
put_template 11 "f6/d6/9b"
put_template 12 "b2/d5/ed"
put_template 13 "e1/c3/ed"
put_template 14 "a7/e6/da"
put_template 15 "ff/f3/e5"

color_foreground="e9/dd/cf"
color_background="21/1c/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e9ddcf"
  put_template_custom Ph "211c1b"
  put_template_custom Pi "e9ddcf"
  put_template_custom Pj "e9ddcf"
  put_template_custom Pk "211c1b"
  put_template_custom Pl "f6d69b"
  put_template_custom Pm "211c1b"
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
