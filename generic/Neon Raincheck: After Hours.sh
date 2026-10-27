#!/bin/sh
# Neon Raincheck: After Hours

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
put_template 0  "18/20/2d"
put_template 1  "b9/5c/7b"
put_template 2  "60/9d/8c"
put_template 3  "b8/a4/6b"
put_template 4  "65/86/c0"
put_template 5  "96/79/c5"
put_template 6  "4c/9f/af"
put_template 7  "a4/b5/c5"
put_template 8  "3d/4c/63"
put_template 9  "d7/7c/99"
put_template 10 "7a/bb/a5"
put_template 11 "d5/c1/83"
put_template 12 "86/a6/dc"
put_template 13 "b6/9a/db"
put_template 14 "6b/c4/d1"
put_template 15 "dc/ea/f2"

color_foreground="b8/c9/d9"
color_background="0b/10/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b8c9d9"
  put_template_custom Ph "0b1019"
  put_template_custom Pi "b8c9d9"
  put_template_custom Pj "202c42"
  put_template_custom Pk "575c66"
  put_template_custom Pl "79c9d8"
  put_template_custom Pm "0b1019"
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
