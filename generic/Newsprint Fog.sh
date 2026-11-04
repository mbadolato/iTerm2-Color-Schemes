#!/bin/sh
# Newsprint Fog

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
put_template 0  "33/33/31"
put_template 1  "b3/40/2e"
put_template 2  "5d/7f/52"
put_template 3  "98/79/21"
put_template 4  "4f/6d/94"
put_template 5  "85/60/7f"
put_template 6  "4d/7f/7c"
put_template 7  "d5/d5/d0"
put_template 8  "78/78/6f"
put_template 9  "cc/4f/3b"
put_template 10 "6f/95/62"
put_template 11 "af/8e/2c"
put_template 12 "61/82/ab"
put_template 13 "9b/74/94"
put_template 14 "5e/96/92"
put_template 15 "fd/fd/fb"

color_foreground="33/33/31"
color_background="f2/f2/f0"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "333331"
  put_template_custom Ph "f2f2f0"
  put_template_custom Pi "333331"
  put_template_custom Pj "ddddd6"
  put_template_custom Pk "333331"
  put_template_custom Pl "b3402e"
  put_template_custom Pm "f2f2f0"
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
