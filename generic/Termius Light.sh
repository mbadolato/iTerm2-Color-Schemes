#!/bin/sh
# Termius Light

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
put_template 0  "14/17/29"
put_template 1  "f2/4e/50"
put_template 2  "19/8c/51"
put_template 3  "ab/69/18"
put_template 4  "00/48/78"
put_template 5  "8f/3c/91"
put_template 6  "20/91/f6"
put_template 7  "ee/ee/ee"
put_template 8  "3e/42/57"
put_template 9  "ff/73/75"
put_template 10 "21/b5/68"
put_template 11 "fd/c4/7d"
put_template 12 "1d/6d/a2"
put_template 13 "ff/7d/c5"
put_template 14 "44/a7/ff"
put_template 15 "ff/ff/ff"

color_foreground="32/36/4a"
color_background="d5/dd/e0"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "32364a"
  put_template_custom Ph "d5dde0"
  put_template_custom Pi "32364a"
  put_template_custom Pj "838995"
  put_template_custom Pk "32364a"
  put_template_custom Pl "32364a"
  put_template_custom Pm "d5dde0"
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
