#!/bin/sh
# Whimsy

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
put_template 0  "53/51/78"
put_template 1  "ef/64/87"
put_template 2  "5e/ca/89"
put_template 3  "fd/d8/77"
put_template 4  "65/ae/f7"
put_template 5  "aa/7f/f0"
put_template 6  "43/c1/be"
put_template 7  "ff/ff/ff"
put_template 8  "53/51/78"
put_template 9  "ef/64/87"
put_template 10 "5e/ca/89"
put_template 11 "fd/d8/77"
put_template 12 "65/ae/f7"
put_template 13 "aa/7f/f0"
put_template 14 "43/c1/be"
put_template 15 "ff/ff/ff"

color_foreground="b3/b0/d6"
color_background="29/28/3b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b3b0d6"
  put_template_custom Ph "29283b"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "3d3c58"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "b3b0d6"
  put_template_custom Pm "535178"
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
