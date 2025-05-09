#!/bin/sh
# Flatland

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
put_template 0  "1d/1d/19"
put_template 1  "f1/83/39"
put_template 2  "9f/d3/64"
put_template 3  "f4/ef/6d"
put_template 4  "50/96/be"
put_template 5  "69/5a/bc"
put_template 6  "d6/38/65"
put_template 7  "ff/ff/ff"
put_template 8  "1d/1d/19"
put_template 9  "d2/2a/24"
put_template 10 "a7/d4/2c"
put_template 11 "ff/89/49"
put_template 12 "61/b9/d0"
put_template 13 "69/5a/bc"
put_template 14 "d6/38/65"
put_template 15 "ff/ff/ff"

color_foreground="b8/db/ef"
color_background="1d/1f/21"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b8dbef"
  put_template_custom Ph "1d1f21"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "2b2a24"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "708284"
  put_template_custom Pm "002831"
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
