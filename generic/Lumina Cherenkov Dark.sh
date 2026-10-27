#!/bin/sh
# Lumina Cherenkov Dark

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
put_template 0  "03/15/30"
put_template 1  "db/6c/64"
put_template 2  "9a/d8/a6"
put_template 3  "ea/d2/93"
put_template 4  "4c/a1/ff"
put_template 5  "ec/af/e6"
put_template 6  "8f/e7/fd"
put_template 7  "b7/c6/d4"
put_template 8  "73/8f/ad"
put_template 9  "e7/90/88"
put_template 10 "b2/f3/bf"
put_template 11 "ff/e6/a4"
put_template 12 "90/bb/ee"
put_template 13 "ff/ce/fa"
put_template 14 "bf/f2/ff"
put_template 15 "d7/e7/f5"

color_foreground="d7/e7/f5"
color_background="02/11/29"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d7e7f5"
  put_template_custom Ph "021129"
  put_template_custom Pi "d7e7f5"
  put_template_custom Pj "10325a"
  put_template_custom Pk "d7e7f5"
  put_template_custom Pl "d7e7f5"
  put_template_custom Pm "021129"
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
