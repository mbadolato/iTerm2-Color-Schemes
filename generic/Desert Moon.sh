#!/bin/sh
# Desert Moon

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
put_template 0  "b9/c6/cb"
put_template 1  "e7/9b/90"
put_template 2  "8f/c9/a3"
put_template 3  "e2/c9/79"
put_template 4  "8d/bf/dd"
put_template 5  "b9/a7/d7"
put_template 6  "80/cd/d0"
put_template 7  "f2/f2/e8"
put_template 8  "cb/d5/d8"
put_template 9  "ef/b0/a7"
put_template 10 "a8/d6/b6"
put_template 11 "ec/d9/95"
put_template 12 "a9/d0/e7"
put_template 13 "ca/bc/e2"
put_template 14 "9b/da/dd"
put_template 15 "ff/fd/f5"

color_foreground="f2/f2/e8"
color_background="0b/34/59"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2f2e8"
  put_template_custom Ph "0b3459"
  put_template_custom Pi "9fd5e7"
  put_template_custom Pj "285273"
  put_template_custom Pk "fffdf2"
  put_template_custom Pl "d9e3d3"
  put_template_custom Pm "0b3459"
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
