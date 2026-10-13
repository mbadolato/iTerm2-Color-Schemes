#!/bin/sh
# Dream Onward

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
put_template 0  "a6/a7/a6"
put_template 1  "dc/78/62"
put_template 2  "91/b8/8c"
put_template 3  "e3/b6/5b"
put_template 4  "7f/a9/c8"
put_template 5  "b9/9a/d4"
put_template 6  "7d/be/b9"
put_template 7  "f7/e7/ce"
put_template 8  "c4/c7/c8"
put_template 9  "e2/8e/7b"
put_template 10 "a3/c3/9e"
put_template 11 "e7/c2/75"
put_template 12 "93/b7/d1"
put_template 13 "c4/aa/db"
put_template 14 "92/c8/c4"
put_template 15 "ff/f9/ee"

color_foreground="f7/e7/ce"
color_background="19/12/0f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7e7ce"
  put_template_custom Ph "19120f"
  put_template_custom Pi "fff9ee"
  put_template_custom Pj "4a3830"
  put_template_custom Pk "fff8ee"
  put_template_custom Pl "e3b65b"
  put_template_custom Pm "19120f"
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
