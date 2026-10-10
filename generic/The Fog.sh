#!/bin/sh
# The Fog

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
put_template 0  "c0/ce/d2"
put_template 1  "ee/9d/8b"
put_template 2  "9b/c8/ad"
put_template 3  "de/c9/78"
put_template 4  "93/c3/d6"
put_template 5  "ba/ad/ca"
put_template 6  "87/ce/d0"
put_template 7  "ee/f4/f3"
put_template 8  "c8/d4/d7"
put_template 9  "f0/a9/99"
put_template 10 "a7/cf/b7"
put_template 11 "e2/cf/88"
put_template 12 "a0/ca/db"
put_template 13 "bf/b2/ce"
put_template 14 "95/d4/d6"
put_template 15 "f0/f5/f4"

color_foreground="ee/f4/f3"
color_background="29/45/52"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eef4f3"
  put_template_custom Ph "294552"
  put_template_custom Pi "e2cf88"
  put_template_custom Pj "c8d4d7"
  put_template_custom Pk "979c9b"
  put_template_custom Pl "f0a999"
  put_template_custom Pm "294552"
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
