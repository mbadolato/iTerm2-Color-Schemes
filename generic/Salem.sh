#!/bin/sh
# Salem

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
put_template 0  "9d/ae/b3"
put_template 1  "e3/6b/61"
put_template 2  "94/c1/7f"
put_template 3  "e6/bc/62"
put_template 4  "78/a9/f0"
put_template 5  "b4/77/cf"
put_template 6  "69/c9/c7"
put_template 7  "e6/dc/c1"
put_template 8  "b6/c5/c9"
put_template 9  "f0/6d/5f"
put_template 10 "a9/d1/8c"
put_template 11 "f4/d5/8b"
put_template 12 "94/b9/f4"
put_template 13 "c9/8d/e0"
put_template 14 "8b/d9/d7"
put_template 15 "ff/f4/da"

color_foreground="e6/dc/c1"
color_background="0f/2a/33"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6dcc1"
  put_template_custom Ph "0f2a33"
  put_template_custom Pi "f4e2a6"
  put_template_custom Pj "29434e"
  put_template_custom Pk "fff4da"
  put_template_custom Pl "f4e2a6"
  put_template_custom Pm "0f2a33"
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
