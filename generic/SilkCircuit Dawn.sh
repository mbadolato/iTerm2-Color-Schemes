#!/bin/sh
# SilkCircuit Dawn

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
put_template 0  "2b/25/40"
put_template 1  "c1/27/2d"
put_template 2  "1d/6e/46"
put_template 3  "79/61/00"
put_template 4  "14/54/dc"
put_template 5  "b4/00/77"
put_template 6  "00/6e/72"
put_template 7  "ba/b8/bf"
put_template 8  "5a/4d/6e"
put_template 9  "dc/26/26"
put_template 10 "28/88/55"
put_template 11 "7f/5f/00"
put_template 12 "25/72/ef"
put_template 13 "d9/2a/99"
put_template 14 "04/83/97"
put_template 15 "ff/ff/ff"

color_foreground="2b/25/40"
color_background="fa/f8/ff"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2b2540"
  put_template_custom Ph "faf8ff"
  put_template_custom Pi "2b2540"
  put_template_custom Pj "d4c8f0"
  put_template_custom Pk "2b2540"
  put_template_custom Pl "006e72"
  put_template_custom Pm "faf8ff"
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
