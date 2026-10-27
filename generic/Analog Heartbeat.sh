#!/bin/sh
# Analog Heartbeat

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
put_template 0  "30/2c/27"
put_template 1  "c9/6f/64"
put_template 2  "94/b2/6a"
put_template 3  "d9/ac/63"
put_template 4  "83/9e/b2"
put_template 5  "b2/8d/a1"
put_template 6  "7e/af/a5"
put_template 7  "d6/cb/b8"
put_template 8  "62/59/4d"
put_template 9  "e5/7b/73"
put_template 10 "b7/d3/6b"
put_template 11 "f2/c8/7b"
put_template 12 "a8/c4/d6"
put_template 13 "d0/a9/bd"
put_template 14 "a1/d4/c5"
put_template 15 "ff/f0/d6"

color_foreground="e6/dd/cb"
color_background="21/1f/1c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6ddcb"
  put_template_custom Ph "211f1c"
  put_template_custom Pi "e6ddcb"
  put_template_custom Pj "454034"
  put_template_custom Pk "6e6b68"
  put_template_custom Pl "f2b35d"
  put_template_custom Pm "211f1c"
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
