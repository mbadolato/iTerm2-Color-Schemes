#!/bin/sh
# Sundried

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
put_template 0  "30/2b/2a"
put_template 1  "a7/46/3d"
put_template 2  "58/77/44"
put_template 3  "9d/60/2a"
put_template 4  "48/5b/98"
put_template 5  "86/46/51"
put_template 6  "9c/81/4f"
put_template 7  "c9/c9/c9"
put_template 8  "4d/4e/48"
put_template 9  "aa/00/0c"
put_template 10 "12/8c/21"
put_template 11 "fc/6a/21"
put_template 12 "79/99/f7"
put_template 13 "fd/8a/a1"
put_template 14 "fa/d4/84"
put_template 15 "ff/ff/ff"

color_foreground="c9/c9/c9"
color_background="1a/18/18"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c9c9c9"
  put_template_custom Ph "1a1818"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "302b2a"
  put_template_custom Pk "c9c9c9"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "191717"
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
