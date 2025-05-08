#!/bin/sh
# Breeze

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
put_template 0  "31/36/3b"
put_template 1  "ed/15/15"
put_template 2  "11/d1/16"
put_template 3  "f6/74/00"
put_template 4  "1d/99/f3"
put_template 5  "9b/59/b6"
put_template 6  "1a/bc/9c"
put_template 7  "ef/f0/f1"
put_template 8  "7f/8c/8d"
put_template 9  "c0/39/2b"
put_template 10 "1c/dc/9a"
put_template 11 "fd/bc/4b"
put_template 12 "3d/ae/e9"
put_template 13 "8e/44/ad"
put_template 14 "16/a0/85"
put_template 15 "fc/fc/fc"

color_foreground="ef/f0/f1"
color_background="31/36/3b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eff0f1"
  put_template_custom Ph "31363b"
  put_template_custom Pi "fcfcfc"
  put_template_custom Pj "eff0f1"
  put_template_custom Pk "31363b"
  put_template_custom Pl "eff0f1"
  put_template_custom Pm "31363b"
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
