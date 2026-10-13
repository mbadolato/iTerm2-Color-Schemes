#!/bin/sh
# Puppet's Master

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
put_template 0  "b5/a6/9a"
put_template 1  "e9/78/5e"
put_template 2  "a4/bc/75"
put_template 3  "e5/b6/5c"
put_template 4  "8d/ae/e0"
put_template 5  "c4/9c/ce"
put_template 6  "7e/c9/c4"
put_template 7  "f5/e6/d5"
put_template 8  "d1/c2/b6"
put_template 9  "f5/95/73"
put_template 10 "be/d0/8e"
put_template 11 "f3/cb/77"
put_template 12 "a9/c4/e9"
put_template 13 "d7/b3/dd"
put_template 14 "9b/db/d4"
put_template 15 "ff/f4/e8"

color_foreground="f5/e6/d5"
color_background="25/15/0e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5e6d5"
  put_template_custom Ph "25150e"
  put_template_custom Pi "fff6e7"
  put_template_custom Pj "583022"
  put_template_custom Pk "fff6e7"
  put_template_custom Pl "f17938"
  put_template_custom Pm "25150e"
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
