#!/bin/sh
# Aura

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
put_template 0  "11/0f/18"
put_template 1  "ff/67/67"
put_template 2  "61/ff/ca"
put_template 3  "ff/ca/85"
put_template 4  "a2/77/ff"
put_template 5  "a2/77/ff"
put_template 6  "61/ff/ca"
put_template 7  "ed/ec/ee"
put_template 8  "4d/4d/4d"
put_template 9  "ff/ca/85"
put_template 10 "a2/77/ff"
put_template 11 "ff/ca/85"
put_template 12 "a2/77/ff"
put_template 13 "a2/77/ff"
put_template 14 "61/ff/ca"
put_template 15 "ed/ec/ee"

color_foreground="ed/ec/ee"
color_background="15/14/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "edecee"
  put_template_custom Ph "15141b"
  put_template_custom Pi "edecee"
  put_template_custom Pj "a277ff"
  put_template_custom Pk "edecee"
  put_template_custom Pl "a277ff"
  put_template_custom Pm "edecee"
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
