#!/bin/sh
# GitHub-Light-Colorblind

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
put_template 0  "24/29/2f"
put_template 1  "b3/59/00"
put_template 2  "05/50/ae"
put_template 3  "4d/2d/00"
put_template 4  "09/69/da"
put_template 5  "82/50/df"
put_template 6  "1b/7c/83"
put_template 7  "6e/77/81"
put_template 8  "57/60/6a"
put_template 9  "8a/46/00"
put_template 10 "09/69/da"
put_template 11 "63/3c/01"
put_template 12 "21/8b/ff"
put_template 13 "a4/75/f9"
put_template 14 "31/92/aa"
put_template 15 "8c/95/9f"

color_foreground="24/29/2f"
color_background="ff/ff/ff"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "24292f"
  put_template_custom Ph "ffffff"
  put_template_custom Pi "24292f"
  put_template_custom Pj "24292f"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "0969da"
  put_template_custom Pm "0969da"
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
