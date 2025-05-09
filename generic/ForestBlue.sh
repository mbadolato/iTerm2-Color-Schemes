#!/bin/sh
# ForestBlue

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
put_template 0  "33/33/33"
put_template 1  "f8/81/8e"
put_template 2  "92/d3/a2"
put_template 3  "1a/8e/63"
put_template 4  "8e/d0/ce"
put_template 5  "5e/46/8c"
put_template 6  "31/65/8c"
put_template 7  "e2/d8/cd"
put_template 8  "3d/3d/3d"
put_template 9  "fb/3d/66"
put_template 10 "6b/b4/8d"
put_template 11 "30/c8/5a"
put_template 12 "39/a7/a2"
put_template 13 "7e/62/b3"
put_template 14 "60/96/bf"
put_template 15 "e2/d8/cd"

color_foreground="e2/d8/cd"
color_background="05/15/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e2d8cd"
  put_template_custom Ph "051519"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "4d4d4d"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "9e9ecb"
  put_template_custom Pm "000000"
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
