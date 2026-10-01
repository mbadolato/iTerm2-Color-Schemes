#!/bin/sh
# Horizons

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
put_template 0  "28/35/48"
put_template 1  "76/15/15"
put_template 2  "12/6b/32"
put_template 3  "75/56/00"
put_template 4  "17/4d/a6"
put_template 5  "65/34/9a"
put_template 6  "00/65/7a"
put_template 7  "3d/48/58"
put_template 8  "53/60/71"
put_template 9  "7d/18/18"
put_template 10 "16/71/3a"
put_template 11 "7a/5c/00"
put_template 12 "12/3d/82"
put_template 13 "6c/3c/a0"
put_template 14 "00/6c/81"
put_template 15 "46/52/64"

color_foreground="0f/17/2a"
color_background="f8/fa/fc"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "0f172a"
  put_template_custom Ph "f8fafc"
  put_template_custom Pi "8a3f00"
  put_template_custom Pj "e2e8f0"
  put_template_custom Pk "0f172a"
  put_template_custom Pl "8a4300"
  put_template_custom Pm "f8fafc"
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
