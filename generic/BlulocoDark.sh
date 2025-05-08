#!/bin/sh
# BlulocoDark

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
put_template 0  "41/44/4d"
put_template 1  "fc/2f/52"
put_template 2  "25/a4/5c"
put_template 3  "ff/93/6a"
put_template 4  "34/76/ff"
put_template 5  "7a/82/da"
put_template 6  "44/83/aa"
put_template 7  "cd/d4/e0"
put_template 8  "8f/9a/ae"
put_template 9  "ff/64/80"
put_template 10 "3f/c5/6b"
put_template 11 "f9/c8/59"
put_template 12 "10/b1/fe"
put_template 13 "ff/78/f8"
put_template 14 "5f/b9/bc"
put_template 15 "ff/ff/ff"

color_foreground="b9/c0/cb"
color_background="28/2c/34"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b9c0cb"
  put_template_custom Ph "282c34"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "b9c0ca"
  put_template_custom Pk "272b33"
  put_template_custom Pl "ffcc00"
  put_template_custom Pm "282c34"
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
