#!/bin/sh
# Lumina Rayleigh Light

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
put_template 0  "1d/2f/47"
put_template 1  "94/17/1b"
put_template 2  "1e/77/3b"
put_template 3  "a3/5f/00"
put_template 4  "01/60/a7"
put_template 5  "8d/44/87"
put_template 6  "05/62/71"
put_template 7  "5d/71/8d"
put_template 8  "57/6c/81"
put_template 9  "6c/1f/1d"
put_template 10 "01/62/2a"
put_template 11 "87/4e/00"
put_template 12 "00/4c/87"
put_template 13 "76/31/71"
put_template 14 "00/4d/59"
put_template 15 "7b/90/ad"

color_foreground="1d/2f/47"
color_background="ed/f8/ff"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1d2f47"
  put_template_custom Ph "edf8ff"
  put_template_custom Pi "1d2f47"
  put_template_custom Pj "b5d0e9"
  put_template_custom Pk "1d2f47"
  put_template_custom Pl "1d2f47"
  put_template_custom Pm "edf8ff"
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
