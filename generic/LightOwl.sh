#!/bin/sh
# LightOwl

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
put_template 0  "40/3f/53"
put_template 1  "de/3d/3b"
put_template 2  "08/91/6a"
put_template 3  "e0/af/02"
put_template 4  "28/8e/d7"
put_template 5  "d6/43/8a"
put_template 6  "2a/a2/98"
put_template 7  "f0/f0/f0"
put_template 8  "98/9f/b1"
put_template 9  "de/3d/3b"
put_template 10 "08/91/6a"
put_template 11 "da/aa/01"
put_template 12 "28/8e/d7"
put_template 13 "d6/43/8a"
put_template 14 "2a/a2/98"
put_template 15 "f0/f0/f0"

color_foreground="40/3f/53"
color_background="fb/fb/fb"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "403f53"
  put_template_custom Ph "fbfbfb"
  put_template_custom Pi "403f53"
  put_template_custom Pj "e0e0e0"
  put_template_custom Pk "403f53"
  put_template_custom Pl "403f53"
  put_template_custom Pm "f6f6f6"
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
