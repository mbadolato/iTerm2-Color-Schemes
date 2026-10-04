#!/bin/sh
# Mesa Twilight

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
put_template 0  "bf/c4/ce"
put_template 1  "f1/95/8c"
put_template 2  "83/cb/a2"
put_template 3  "e9/c9/6c"
put_template 4  "83/b9/e6"
put_template 5  "c8/9e/db"
put_template 6  "78/ce/d3"
put_template 7  "ff/f0/df"
put_template 8  "d0/d4/dc"
put_template 9  "f8/ac/a5"
put_template 10 "9d/d8/b5"
put_template 11 "f2/d9/8a"
put_template 12 "9f/ca/f0"
put_template 13 "d9/b6/e5"
put_template 14 "97/dc/e0"
put_template 15 "ff/fa/f2"

color_foreground="ff/f0/df"
color_background="17/2b/54"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0df"
  put_template_custom Ph "172b54"
  put_template_custom Pi "ff9879"
  put_template_custom Pj "34496d"
  put_template_custom Pk "fff8ed"
  put_template_custom Pl "f3b85b"
  put_template_custom Pm "172b54"
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
