#!/bin/sh
# Numbers Station

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
put_template 0  "b8/b4/c1"
put_template 1  "f0/81/88"
put_template 2  "79/d0/a1"
put_template 3  "e9/cb/69"
put_template 4  "88/b3/e9"
put_template 5  "d5/a2/e6"
put_template 6  "7b/d3/da"
put_template 7  "f0/ed/f6"
put_template 8  "cb/c7/d2"
put_template 9  "f2/9c/a2"
put_template 10 "98/de/b7"
put_template 11 "ef/dc/8a"
put_template 12 "a7/c8/f0"
put_template 13 "e3/ba/ed"
put_template 14 "9c/e2/e5"
put_template 15 "ff/ff/ff"

color_foreground="f0/ed/f6"
color_background="0d/0b/12"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f0edf6"
  put_template_custom Ph "0d0b12"
  put_template_custom Pi "d9a7ff"
  put_template_custom Pj "30283b"
  put_template_custom Pk "fbf8ff"
  put_template_custom Pl "c5a0ff"
  put_template_custom Pm "0d0b12"
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
