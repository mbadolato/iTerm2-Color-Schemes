#!/bin/sh
# Slate

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
put_template 0  "22/22/22"
put_template 1  "e2/a8/bf"
put_template 2  "81/d7/78"
put_template 3  "c4/c9/c0"
put_template 4  "26/4b/49"
put_template 5  "a4/81/d3"
put_template 6  "15/ab/9c"
put_template 7  "02/c5/e0"
put_template 8  "ff/ff/ff"
put_template 9  "ff/cd/d9"
put_template 10 "be/ff/a8"
put_template 11 "d0/cc/ca"
put_template 12 "7a/b0/d2"
put_template 13 "c5/a7/d9"
put_template 14 "8c/df/e0"
put_template 15 "e0/e0/e0"

color_foreground="35/b1/d2"
color_background="22/22/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "35b1d2"
  put_template_custom Ph "222222"
  put_template_custom Pi "648890"
  put_template_custom Pj "0f3754"
  put_template_custom Pk "2dffc0"
  put_template_custom Pl "87d3c4"
  put_template_custom Pm "323232"
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
