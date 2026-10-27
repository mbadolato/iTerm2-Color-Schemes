#!/bin/sh
# Lumina Parchment Light

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
put_template 0  "35/25/16"
put_template 1  "91/29/18"
put_template 2  "2d/73/41"
put_template 3  "65/49/35"
put_template 4  "2e/5f/b0"
put_template 5  "87/41/8e"
put_template 6  "00/6e/81"
put_template 7  "7b/68/58"
put_template 8  "70/62/51"
put_template 9  "6b/28/1c"
put_template 10 "19/5e/2f"
put_template 11 "5f/2f/00"
put_template 12 "28/4d/8a"
put_template 13 "6b/37/70"
put_template 14 "00/58/68"
put_template 15 "9b/87/76"

color_foreground="35/25/16"
color_background="f9/ef/da"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "352516"
  put_template_custom Ph "f9efda"
  put_template_custom Pi "352516"
  put_template_custom Pj "d4be95"
  put_template_custom Pk "352516"
  put_template_custom Pl "352516"
  put_template_custom Pm "f9efda"
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
