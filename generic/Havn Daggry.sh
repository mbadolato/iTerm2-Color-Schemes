#!/bin/sh
# Havn Daggry

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
put_template 0  "1f/28/42"
put_template 1  "98/52/48"
put_template 2  "57/71/59"
put_template 3  "be/6b/00"
put_template 4  "3a/57/7d"
put_template 5  "7c/5c/97"
put_template 6  "92/57/80"
put_template 7  "b0/b5/c5"
put_template 8  "1f/28/42"
put_template 9  "cc/4a/35"
put_template 10 "71/96/79"
put_template 11 "f1/a5/27"
put_template 12 "60/89/c0"
put_template 13 "7d/73/96"
put_template 14 "aa/86/9d"
put_template 15 "d6/db/eb"

color_foreground="3b/4a/7a"
color_background="f8/f9/fb"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3b4a7a"
  put_template_custom Ph "f8f9fb"
  put_template_custom Pi "414d7c"
  put_template_custom Pj "cfe9dd"
  put_template_custom Pk "313c64"
  put_template_custom Pl "226c4f"
  put_template_custom Pm "d6dbeb"
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
