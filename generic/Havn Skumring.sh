#!/bin/sh
# Havn Skumring

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
put_template 0  "25/2c/47"
put_template 1  "ea/56/3e"
put_template 2  "6e/ad/7b"
put_template 3  "f8/b3/30"
put_template 4  "59/6c/f7"
put_template 5  "7c/71/9e"
put_template 6  "d5/88/c1"
put_template 7  "dc/e0/ee"
put_template 8  "38/42/5c"
put_template 9  "d1/72/64"
put_template 10 "8c/9e/8f"
put_template 11 "ea/c5/8c"
put_template 12 "51/86/cb"
put_template 13 "9b/7c/ee"
put_template 14 "d1/7a/b6"
put_template 15 "ff/f6/e1"

color_foreground="d6/db/eb"
color_background="11/15/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d6dbeb"
  put_template_custom Ph "111522"
  put_template_custom Pi "d0d4e2"
  put_template_custom Pj "2b514b"
  put_template_custom Pk "dce0ef"
  put_template_custom Pl "277a6f"
  put_template_custom Pm "e0e4f3"
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
