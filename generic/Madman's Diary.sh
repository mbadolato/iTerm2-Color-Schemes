#!/bin/sh
# Madman's Diary

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
put_template 0  "3b/19/19"
put_template 1  "8b/1e/3e"
put_template 2  "d2/59/44"
put_template 3  "59/ae/08"
put_template 4  "fb/bf/24"
put_template 5  "a8/55/f7"
put_template 6  "ef/44/44"
put_template 7  "f4/72/b6"
put_template 8  "5a/3a/2e"
put_template 9  "fb/71/85"
put_template 10 "34/d3/99"
put_template 11 "fd/e0/47"
put_template 12 "60/a5/fa"
put_template 13 "c0/84/fc"
put_template 14 "22/d3/ee"
put_template 15 "ff/f7/e6"

color_foreground="f4/e7/d7"
color_background="1a/0e/17"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f4e7d7"
  put_template_custom Ph "1a0e17"
  put_template_custom Pi "ffcc00"
  put_template_custom Pj "ff6633"
  put_template_custom Pk "ffeb83"
  put_template_custom Pl "ff3e3e"
  put_template_custom Pm "3a1b15"
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
