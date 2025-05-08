#!/bin/sh
# AtomOneDark

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
put_template 0  "21/25/2b"
put_template 1  "e0/6c/75"
put_template 2  "98/c3/79"
put_template 3  "e5/c0/7b"
put_template 4  "61/af/ef"
put_template 5  "c6/78/dd"
put_template 6  "56/b6/c2"
put_template 7  "ab/b2/bf"
put_template 8  "76/76/76"
put_template 9  "e0/6c/75"
put_template 10 "98/c3/79"
put_template 11 "e5/c0/7b"
put_template 12 "61/af/ef"
put_template 13 "c6/78/dd"
put_template 14 "56/b6/c2"
put_template 15 "ab/b2/bf"

color_foreground="ab/b2/bf"
color_background="21/25/2b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "abb2bf"
  put_template_custom Ph "21252b"
  put_template_custom Pi "abb2bf"
  put_template_custom Pj "323844"
  put_template_custom Pk "abb2bf"
  put_template_custom Pl "abb2bf"
  put_template_custom Pm "abb2bf"
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
