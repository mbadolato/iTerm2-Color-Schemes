#!/bin/sh
# OpenCode Dark

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
put_template 0  "1e/1e/1e"
put_template 1  "e0/6c/75"
put_template 2  "7f/d8/8f"
put_template 3  "f5/a7/42"
put_template 4  "5c/9c/f5"
put_template 5  "9d/7c/d8"
put_template 6  "56/b6/c2"
put_template 7  "ee/ee/ee"
put_template 8  "80/80/80"
put_template 9  "fd/7e/87"
put_template 10 "96/f7/a7"
put_template 11 "fa/b2/83"
put_template 12 "82/b4/fb"
put_template 13 "b3/8f/f4"
put_template 14 "68/d0/dd"
put_template 15 "ff/ff/ff"

color_foreground="ee/ee/ee"
color_background="0a/0a/0a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eeeeee"
  put_template_custom Ph "0a0a0a"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "3d1d06"
  put_template_custom Pk "eeeeee"
  put_template_custom Pl "fab283"
  put_template_custom Pm "0a0a0a"
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
