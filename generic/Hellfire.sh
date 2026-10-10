#!/bin/sh
# Hellfire

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
put_template 0  "c5/af/a7"
put_template 1  "f2/81/5f"
put_template 2  "a9/bd/72"
put_template 3  "e8/bd/4e"
put_template 4  "83/a9/c2"
put_template 5  "bf/87/9f"
put_template 6  "76/b6/ad"
put_template 7  "f8/e2/c7"
put_template 8  "cc/b9/b2"
put_template 9  "f4/90/72"
put_template 10 "b3/c5/83"
put_template 11 "eb/c5/63"
put_template 12 "92/b3/c9"
put_template 13 "c7/95/ab"
put_template 14 "86/bf/b7"
put_template 15 "f9/e5/ce"

color_foreground="f8/e2/c7"
color_background="5b/0e/05"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8e2c7"
  put_template_custom Ph "5b0e05"
  put_template_custom Pi "ebc563"
  put_template_custom Pj "ccb9b2"
  put_template_custom Pk "937f68"
  put_template_custom Pl "f49072"
  put_template_custom Pm "5b0e05"
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
