#!/bin/sh
# Pharaoh's Voltage

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
put_template 0  "a8/b2/b8"
put_template 1  "ea/91/66"
put_template 2  "8b/c4/9c"
put_template 3  "e9/c3/66"
put_template 4  "78/b9/e8"
put_template 5  "c7/9c/da"
put_template 6  "74/d5/d6"
put_template 7  "f8/e9/ca"
put_template 8  "b9/c1/c6"
put_template 9  "ed/9e/78"
put_template 10 "99/cb/a8"
put_template 11 "ec/ca/78"
put_template 12 "88/c1/eb"
put_template 13 "ce/a8/de"
put_template 14 "85/da/db"
put_template 15 "f9/ed/d5"

color_foreground="f8/e9/ca"
color_background="10/2c/3c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8e9ca"
  put_template_custom Ph "102c3c"
  put_template_custom Pi "f9edd5"
  put_template_custom Pj "3e4556"
  put_template_custom Pk "f8e9ca"
  put_template_custom Pl "ecca78"
  put_template_custom Pm "102c3c"
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
