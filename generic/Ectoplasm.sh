#!/bin/sh
# Ectoplasm

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
put_template 0  "c1/d0/cf"
put_template 1  "f1/9b/8d"
put_template 2  "78/e0/aa"
put_template 3  "d7/dd/5e"
put_template 4  "76/c9/ef"
put_template 5  "af/a1/e9"
put_template 6  "58/e0/d6"
put_template 7  "ef/ff/fb"
put_template 8  "c8/d6/d5"
put_template 9  "f3/a7/9b"
put_template 10 "88/e4/b4"
put_template 11 "dc/e1/71"
put_template 12 "86/cf/f1"
put_template 13 "b4/a7/eb"
put_template 14 "6c/e4/db"
put_template 15 "f1/ff/fb"

color_foreground="ef/ff/fb"
color_background="06/45/4a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "effffb"
  put_template_custom Ph "06454a"
  put_template_custom Pi "dce171"
  put_template_custom Pj "c8d6d5"
  put_template_custom Pk "8b9995"
  put_template_custom Pl "f3a79b"
  put_template_custom Pm "06454a"
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
