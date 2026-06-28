#!/bin/sh
# Citrus Ink

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
put_template 0  "14/20/1e"
put_template 1  "ff/6b/5b"
put_template 2  "5f/d3/a0"
put_template 3  "e6/c8/4a"
put_template 4  "c2/ef/45"
put_template 5  "f2/b4/41"
put_template 6  "cf/e8/9a"
put_template 7  "ea/f0/e2"
put_template 8  "4f/6b/5e"
put_template 9  "ff/81/74"
put_template 10 "72/d8/ab"
put_template 11 "f2/a2/3e"
put_template 12 "b8/e6/2e"
put_template 13 "b8/e6/2e"
put_template 14 "d5/eb/a6"
put_template 15 "ff/ff/ff"

color_foreground="ea/f0/e2"
color_background="0b/14/13"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eaf0e2"
  put_template_custom Ph "0b1413"
  put_template_custom Pi "eaf0e2"
  put_template_custom Pj "1f302d"
  put_template_custom Pk "4b5453"
  put_template_custom Pl "b8e62e"
  put_template_custom Pm "0b1413"
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
