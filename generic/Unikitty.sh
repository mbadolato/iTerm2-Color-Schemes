#!/bin/sh
# Unikitty

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
put_template 0  "0c/0c/0c"
put_template 1  "a8/0f/20"
put_template 2  "ba/fc/8b"
put_template 3  "ee/df/4b"
put_template 4  "14/5f/cd"
put_template 5  "ff/36/a2"
put_template 6  "6b/d1/bc"
put_template 7  "e2/d7/e1"
put_template 8  "43/43/43"
put_template 9  "d9/13/29"
put_template 10 "d3/ff/af"
put_template 11 "ff/ef/50"
put_template 12 "00/75/ea"
put_template 13 "fd/d5/e5"
put_template 14 "79/ec/d5"
put_template 15 "ff/f3/fe"

color_foreground="0b/0b/0b"
color_background="ff/8c/d9"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "0b0b0b"
  put_template_custom Ph "ff8cd9"
  put_template_custom Pi "000000"
  put_template_custom Pj "3ea9fe"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "bafc8b"
  put_template_custom Pm "202020"
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
