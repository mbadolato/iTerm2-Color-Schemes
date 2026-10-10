#!/bin/sh
# Jack O' Lantern

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
put_template 0  "bd/b2/a4"
put_template 1  "ff/8b/61"
put_template 2  "8d/cc/7a"
put_template 3  "f3/c9/69"
put_template 4  "8f/c5/e8"
put_template 5  "dc/a2/c9"
put_template 6  "7f/d3/cf"
put_template 7  "ff/f0/d5"
put_template 8  "d1/c7/ba"
put_template 9  "ff/a0/7c"
put_template 10 "a5/d9/9a"
put_template 11 "f8/d9/8a"
put_template 12 "ac/d5/ef"
put_template 13 "e8/ba/d8"
put_template 14 "9f/e1/dc"
put_template 15 "ff/fa/f0"

color_foreground="ff/f0/d5"
color_background="4a/1b/08"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d5"
  put_template_custom Ph "4a1b08"
  put_template_custom Pi "ffb347"
  put_template_custom Pj "713514"
  put_template_custom Pk "fff7e8"
  put_template_custom Pl "ff9f1c"
  put_template_custom Pm "4a1b08"
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
