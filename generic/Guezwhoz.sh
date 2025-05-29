#!/bin/sh
# Guezwhoz

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
put_template 1  "f3/57/82"
put_template 2  "7f/d6/93"
put_template 3  "b4/ca/74"
put_template 4  "60/a0/d7"
put_template 5  "9a/90/e0"
put_template 6  "69/da/d0"
put_template 7  "da/da/da"
put_template 8  "80/80/80"
put_template 9  "f3/57/82"
put_template 10 "b0/d7/af"
put_template 11 "cb/ee/7b"
put_template 12 "52/b5/f4"
put_template 13 "a6/98/f5"
put_template 14 "70/e3/d9"
put_template 15 "ed/ed/ed"

color_foreground="d9/d9/d9"
color_background="1e/1e/1e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d9d9d9"
  put_template_custom Ph "1e1e1e"
  put_template_custom Pi "eeeeee"
  put_template_custom Pj "195555"
  put_template_custom Pk "8be0d8"
  put_template_custom Pl "8cd7af"
  put_template_custom Pm "1d1d1d"
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
