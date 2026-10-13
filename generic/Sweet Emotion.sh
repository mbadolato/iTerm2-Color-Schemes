#!/bin/sh
# Sweet Emotion

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
put_template 1  "ee/75/a8"
put_template 2  "78/c6/a6"
put_template 3  "e6/b8/6b"
put_template 4  "89/a8/ee"
put_template 5  "c3/8b/ec"
put_template 6  "75/cb/d6"
put_template 7  "f9/e5/f4"
put_template 8  "c4/c7/c8"
put_template 9  "f1/8b/b6"
put_template 10 "8e/cf/b4"
put_template 11 "ea/c3/83"
put_template 12 "9c/b6/f1"
put_template 13 "cd/9e/ef"
put_template 14 "8b/d3/dd"
put_template 15 "ff/f9/ee"

color_foreground="f9/e5/f4"
color_background="21/10/27"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f9e5f4"
  put_template_custom Ph "211027"
  put_template_custom Pi "fff9ee"
  put_template_custom Pj "49343d"
  put_template_custom Pk "fff8ee"
  put_template_custom Pl "e6b86b"
  put_template_custom Pm "211027"
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
