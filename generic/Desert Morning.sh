#!/bin/sh
# Desert Morning

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
put_template 0  "4a/35/29"
put_template 1  "7e/2c/23"
put_template 2  "29/4f/2e"
put_template 3  "62/43/0b"
put_template 4  "27/49/78"
put_template 5  "61/38/6a"
put_template 6  "1a/4f/51"
put_template 7  "35/24/17"
put_template 8  "5c/43/36"
put_template 9  "7d/30/25"
put_template 10 "30/4e/33"
put_template 11 "60/43/0e"
put_template 12 "27/48/75"
put_template 13 "60/3b/6a"
put_template 14 "1e/4f/52"
put_template 15 "24/17/0e"

color_foreground="35/24/17"
color_background="d8/b5/90"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "352417"
  put_template_custom Ph "d8b590"
  put_template_custom Pi "60430e"
  put_template_custom Pj "5b3c28"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "60430e"
  put_template_custom Pm "d8b590"
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
