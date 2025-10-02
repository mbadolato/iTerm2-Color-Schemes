#!/bin/sh
# One Double Dark

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
put_template 0  "3d/44/52"
put_template 1  "f1/63/72"
put_template 2  "8c/c5/70"
put_template 3  "ec/be/70"
put_template 4  "3f/b1/f5"
put_template 5  "d3/73/e3"
put_template 6  "17/b9/c4"
put_template 7  "db/df/e5"
put_template 8  "52/5d/6f"
put_template 9  "ff/77/7b"
put_template 10 "82/d8/82"
put_template 11 "f5/c0/65"
put_template 12 "6d/ca/ff"
put_template 13 "ff/7b/f4"
put_template 14 "00/e5/fb"
put_template 15 "f7/f9/fc"

color_foreground="db/df/e5"
color_background="28/2c/34"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dbdfe5"
  put_template_custom Ph "282c34"
  put_template_custom Pi "f7f9fc"
  put_template_custom Pj "585b70"
  put_template_custom Pk "cdd6f4"
  put_template_custom Pl "f5e0dc"
  put_template_custom Pm "9aa3c1"
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
