#!/bin/sh
# Sugarplum

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
put_template 0  "11/11/47"
put_template 1  "5c/a8/dc"
put_template 2  "53/b3/97"
put_template 3  "24/9a/84"
put_template 4  "db/7d/dd"
put_template 5  "d0/be/ee"
put_template 6  "f9/f3/f9"
put_template 7  "a1/75/d4"
put_template 8  "11/11/47"
put_template 9  "5c/b5/dc"
put_template 10 "52/de/b5"
put_template 11 "01/f5/c7"
put_template 12 "fa/5d/fd"
put_template 13 "c6/a5/fd"
put_template 14 "ff/ff/ff"
put_template 15 "b5/77/fd"

color_foreground="db/7d/dd"
color_background="11/11/47"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "db7ddd"
  put_template_custom Ph "111147"
  put_template_custom Pi "d0beee"
  put_template_custom Pj "5ca8dc"
  put_template_custom Pk "d0beee"
  put_template_custom Pl "53b397"
  put_template_custom Pm "53b397"
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
