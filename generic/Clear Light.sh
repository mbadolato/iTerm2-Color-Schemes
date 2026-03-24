#!/bin/sh
# Clear Light

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
put_template 0  "2d/38/40"
put_template 1  "b4/56/48"
put_template 2  "6c/aa/71"
put_template 3  "c4/ac/62"
put_template 4  "56/85/a8"
put_template 5  "ad/64/be"
put_template 6  "69/c6/c9"
put_template 7  "b4/bb/bf"
put_template 8  "50/65/73"
put_template 9  "df/6c/5a"
put_template 10 "79/be/7e"
put_template 11 "d8/bb/65"
put_template 12 "49/a2/e1"
put_template 13 "d3/89/e5"
put_template 14 "5e/c7/cb"
put_template 15 "d8/e1/e7"

color_foreground="3a/48/51"
color_background="ff/ff/ff"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3a4851"
  put_template_custom Ph "ffffff"
  put_template_custom Pi "313c44"
  put_template_custom Pj "e5ecf1"
  put_template_custom Pk "b2b2b2"
  put_template_custom Pl "919191"
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
