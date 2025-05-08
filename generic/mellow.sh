#!/bin/sh
# mellow

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
put_template 0  "27/27/2a"
put_template 1  "f5/a1/91"
put_template 2  "90/b9/9f"
put_template 3  "e6/b9/9d"
put_template 4  "ac/a1/cf"
put_template 5  "e2/9e/ca"
put_template 6  "ea/83/a5"
put_template 7  "c1/c0/d4"
put_template 8  "35/35/39"
put_template 9  "ff/ae/9f"
put_template 10 "9d/c6/ac"
put_template 11 "f0/c5/a9"
put_template 12 "b9/ae/da"
put_template 13 "ec/aa/d6"
put_template 14 "f5/91/b2"
put_template 15 "ca/c9/dd"

color_foreground="c9/c7/cd"
color_background="16/16/17"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c9c7cd"
  put_template_custom Ph "161617"
  put_template_custom Pi "eaeaea"
  put_template_custom Pj "2a2a2d"
  put_template_custom Pk "c1c0d4"
  put_template_custom Pl "cac9dd"
  put_template_custom Pm "161617"
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
