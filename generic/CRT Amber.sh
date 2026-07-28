#!/bin/sh
# CRT Amber

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
put_template 0  "4c/42/2f"
put_template 1  "ef/44/44"
put_template 2  "84/cc/16"
put_template 3  "fd/e6/8a"
put_template 4  "c0/84/fc"
put_template 5  "f9/73/16"
put_template 6  "f5/9e/0b"
put_template 7  "d8/a6/57"
put_template 8  "54/44/35"
put_template 9  "f2/69/69"
put_template 10 "9d/d6/45"
put_template 11 "fd/eb/9f"
put_template 12 "cd/9d/fd"
put_template 13 "fa/8f/45"
put_template 14 "f7/b1/3c"
put_template 15 "ff/f3/c4"

color_foreground="ff/f3/c4"
color_background="1a/10/05"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff3c4"
  put_template_custom Ph "1a1005"
  put_template_custom Pi "fff3c4"
  put_template_custom Pj "fff3c4"
  put_template_custom Pk "1a1005"
  put_template_custom Pl "fff3c4"
  put_template_custom Pm "1a1005"
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
