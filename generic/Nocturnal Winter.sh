#!/bin/sh
# Nocturnal Winter

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
put_template 0  "4d/4d/4d"
put_template 1  "f1/2d/52"
put_template 2  "09/cd/7e"
put_template 3  "f5/f1/7a"
put_template 4  "31/82/e0"
put_template 5  "ff/2b/6d"
put_template 6  "09/c8/7a"
put_template 7  "fc/fc/fc"
put_template 8  "80/80/80"
put_template 9  "f1/6d/86"
put_template 10 "0a/e7/8d"
put_template 11 "ff/fc/67"
put_template 12 "60/96/ff"
put_template 13 "ff/78/a2"
put_template 14 "0a/e7/8d"
put_template 15 "ff/ff/ff"

color_foreground="e6/e5/e5"
color_background="0d/0d/17"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e5e5"
  put_template_custom Ph "0d0d17"
  put_template_custom Pi "e8e8e8"
  put_template_custom Pj "adbdd0"
  put_template_custom Pk "000000"
  put_template_custom Pl "e6e5e5"
  put_template_custom Pm "ffffff"
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
