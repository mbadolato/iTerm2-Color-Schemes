#!/bin/sh
# JetBrains Islands Dark

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
put_template 0  "19/1a/1c"
put_template 1  "f7/54/64"
put_template 2  "6a/ab/73"
put_template 3  "cf/8e/6d"
put_template 4  "56/a8/f5"
put_template 5  "c7/7d/bb"
put_template 6  "2a/ac/b8"
put_template 7  "bc/be/c4"
put_template 8  "7a/7e/85"
put_template 9  "f5/7e/84"
put_template 10 "6d/b0/83"
put_template 11 "f0/ac/81"
put_template 12 "54/8a/f7"
put_template 13 "b1/89/f5"
put_template 14 "16/ba/ac"
put_template 15 "ff/ff/ff"

color_foreground="bc/be/c4"
color_background="19/1a/1c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "bcbec4"
  put_template_custom Ph "191a1c"
  put_template_custom Pi "bcbec4"
  put_template_custom Pj "2a4371"
  put_template_custom Pk "d1d3d9"
  put_template_custom Pl "ced0d6"
  put_template_custom Pm "191a1c"
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
