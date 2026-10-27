#!/bin/sh
# Lumina Canopy Light

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
put_template 0  "1e/33/23"
put_template 1  "86/0c/2c"
put_template 2  "33/75/45"
put_template 3  "90/57/05"
put_template 4  "04/6a/a7"
put_template 5  "86/4c/82"
put_template 6  "00/71/84"
put_template 7  "5e/75/63"
put_template 8  "5b/6f/5d"
put_template 9  "5b/1d/26"
put_template 10 "20/60/33"
put_template 11 "76/46/00"
put_template 12 "0e/56/86"
put_template 13 "70/39/6c"
put_template 14 "00/5b/6b"
put_template 15 "7d/95/82"

color_foreground="1e/33/23"
color_background="f1/f9/ef"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1e3323"
  put_template_custom Ph "f1f9ef"
  put_template_custom Pi "1e3323"
  put_template_custom Pj "cecda8"
  put_template_custom Pk "1e3323"
  put_template_custom Pl "1e3323"
  put_template_custom Pm "f1f9ef"
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
