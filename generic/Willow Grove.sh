#!/bin/sh
# Willow Grove

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
put_template 0  "29/2d/27"
put_template 1  "84/1d/1d"
put_template 2  "0b/57/29"
put_template 3  "62/48/00"
put_template 4  "17/47/8f"
put_template 5  "5d/2d/87"
put_template 6  "00/56/64"
put_template 7  "3b/40/38"
put_template 8  "53/59/50"
put_template 9  "90/23/23"
put_template 10 "0b/5c/2e"
put_template 11 "68/4e/00"
put_template 12 "19/4d/99"
put_template 13 "65/35/8e"
put_template 14 "00/5e/6e"
put_template 15 "45/4a/42"

color_foreground="1b/1f/16"
color_background="fd/fc/f5"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1b1f16"
  put_template_custom Ph "fdfcf5"
  put_template_custom Pi "0f7d32"
  put_template_custom Pj "e6ddc6"
  put_template_custom Pk "1b1f16"
  put_template_custom Pl "0b7285"
  put_template_custom Pm "fdfcf5"
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
