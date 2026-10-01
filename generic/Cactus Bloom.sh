#!/bin/sh
# Cactus Bloom

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
put_template 0  "29/2d/29"
put_template 1  "8c/1b/1b"
put_template 2  "0d/5b/30"
put_template 3  "68/4b/00"
put_template 4  "17/4b/9a"
put_template 5  "61/2d/8e"
put_template 6  "00/5b/69"
put_template 7  "3a/40/3a"
put_template 8  "46/4c/46"
put_template 9  "96/1f/1f"
put_template 10 "10/62/34"
put_template 11 "70/4f/00"
put_template 12 "12/3a/78"
put_template 13 "69/36/96"
put_template 14 "00/4a/57"
put_template 15 "45/4b/45"

color_foreground="11/1a/11"
color_background="ff/f9/f0"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "111a11"
  put_template_custom Ph "fff9f0"
  put_template_custom Pi "c2410c"
  put_template_custom Pj "f1dcc4"
  put_template_custom Pk "111a11"
  put_template_custom Pl "0b6897"
  put_template_custom Pm "fff9f0"
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
