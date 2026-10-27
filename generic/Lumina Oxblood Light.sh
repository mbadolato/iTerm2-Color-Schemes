#!/bin/sh
# Lumina Oxblood Light

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
put_template 0  "42/22/2f"
put_template 1  "9b/28/27"
put_template 2  "23/77/42"
put_template 3  "a1/60/0a"
put_template 4  "31/66/a6"
put_template 5  "82/46/9d"
put_template 6  "08/73/80"
put_template 7  "8a/64/72"
put_template 8  "7d/5d/68"
put_template 9  "73/29/26"
put_template 10 "0f/61/31"
put_template 11 "87/4e/00"
put_template 12 "1c/52/90"
put_template 13 "68/3a/7d"
put_template 14 "00/5d/68"
put_template 15 "ab/83/92"

color_foreground="42/22/2f"
color_background="fe/f2/f4"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "42222f"
  put_template_custom Ph "fef2f4"
  put_template_custom Pi "42222f"
  put_template_custom Pj "e6b8cb"
  put_template_custom Pk "42222f"
  put_template_custom Pl "42222f"
  put_template_custom Pm "fef2f4"
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
