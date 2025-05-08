#!/bin/sh
# rebecca

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
put_template 0  "12/13/1e"
put_template 1  "dd/77/55"
put_template 2  "04/db/b5"
put_template 3  "f2/e7/b7"
put_template 4  "7a/a5/ff"
put_template 5  "bf/9c/f9"
put_template 6  "56/d3/c2"
put_template 7  "e4/e3/e9"
put_template 8  "66/66/99"
put_template 9  "ff/92/cd"
put_template 10 "01/ea/c0"
put_template 11 "ff/fc/a8"
put_template 12 "69/c0/fa"
put_template 13 "c1/7f/f8"
put_template 14 "8b/fd/e1"
put_template 15 "f4/f2/f9"

color_foreground="e8/e6/ed"
color_background="29/2a/44"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8e6ed"
  put_template_custom Ph "292a44"
  put_template_custom Pi "ccccff"
  put_template_custom Pj "663399"
  put_template_custom Pk "f4f2f9"
  put_template_custom Pl "b89bf9"
  put_template_custom Pm "292a44"
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
