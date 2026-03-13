#!/bin/sh
# Monospace Dark

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
put_template 0  "73/82/95"
put_template 1  "f7/67/69"
put_template 2  "17/b8/77"
put_template 3  "ff/a2/3e"
put_template 4  "70/8f/ff"
put_template 5  "a8/7f/fb"
put_template 6  "25/a6/e9"
put_template 7  "a4/af/bd"
put_template 8  "8b/98/a9"
put_template 9  "fc/8f/8e"
put_template 10 "66/ce/98"
put_template 11 "ff/c2/6e"
put_template 12 "a2/b6/ff"
put_template 13 "c8/aa/ff"
put_template 14 "71/c2/ee"
put_template 15 "fa/fb/fe"

color_foreground="a4/af/bd"
color_background="10/15/1d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "a4afbd"
  put_template_custom Ph "10151d"
  put_template_custom Pi "d9dfe7"
  put_template_custom Pj "264dcb"
  put_template_custom Pk "d9dfe7"
  put_template_custom Pl "c8aaff"
  put_template_custom Pm "10151d"
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
