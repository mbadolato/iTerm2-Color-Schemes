#!/bin/sh
# Token Dark

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
put_template 0  "1d/1d/1c"
put_template 1  "c6/77/77"
put_template 2  "7d/a4/7a"
put_template 3  "c4/a8/55"
put_template 4  "7b/9e/bd"
put_template 5  "a6/8b/bf"
put_template 6  "6b/a8/a8"
put_template 7  "d4/cf/c6"
put_template 8  "5a/59/55"
put_template 9  "d9/77/57"
put_template 10 "98/bf/95"
put_template 11 "c4/95/6a"
put_template 12 "96/b8/d3"
put_template 13 "be/a5/d4"
put_template 14 "88/c0/c0"
put_template 15 "e8/e4/dc"

color_foreground="e8/e4/dc"
color_background="26/26/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8e4dc"
  put_template_custom Ph "262624"
  put_template_custom Pi "e8e4dc"
  put_template_custom Pj "3a3a37"
  put_template_custom Pk "e8e4dc"
  put_template_custom Pl "e8e4dc"
  put_template_custom Pm "262624"
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
