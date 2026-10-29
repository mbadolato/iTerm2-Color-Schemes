#!/bin/sh
# Rainbows and Unicorns Mane

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
put_template 0  "24/22/2e"
put_template 1  "eb/41/3a"
put_template 2  "68/c4/4a"
put_template 3  "fe/de/3c"
put_template 4  "30/92/e2"
put_template 5  "b8/66/d6"
put_template 6  "45/c8/c0"
put_template 7  "c8/ca/e4"
put_template 8  "6e/6a/82"
put_template 9  "fa/82/1e"
put_template 10 "8f/db/74"
put_template 11 "ff/e9/78"
put_template 12 "62/b0/f0"
put_template 13 "f0/a0/be"
put_template 14 "7f/e0/d8"
put_template 15 "ff/ff/ff"

color_foreground="e9/e7/f2"
color_background="14/13/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e9e7f2"
  put_template_custom Ph "14131a"
  put_template_custom Pi "e9e7f2"
  put_template_custom Pj "9230aa"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "ffd65a"
  put_template_custom Pm "14131a"
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
