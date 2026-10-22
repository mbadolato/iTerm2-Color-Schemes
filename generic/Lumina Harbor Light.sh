#!/bin/sh
# Lumina Harbor Light

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
put_template 0  "1b/27/37"
put_template 1  "99/2a/28"
put_template 2  "00/77/42"
put_template 3  "a5/58/00"
put_template 4  "28/63/ab"
put_template 5  "87/48/82"
put_template 6  "00/6f/82"
put_template 7  "5f/6d/80"
put_template 8  "62/70/80"
put_template 9  "71/2a/26"
put_template 10 "08/60/35"
put_template 11 "88/48/06"
put_template 12 "1e/50/8b"
put_template 13 "70/36/6c"
put_template 14 "00/59/69"
put_template 15 "7e/8c/a0"

color_foreground="1b/27/37"
color_background="e6/f2/fe"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1b2737"
  put_template_custom Ph "e6f2fe"
  put_template_custom Pi "1b2737"
  put_template_custom Pj "a9d1d5"
  put_template_custom Pk "1b2737"
  put_template_custom Pl "1b2737"
  put_template_custom Pm "e6f2fe"
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
