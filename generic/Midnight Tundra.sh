#!/bin/sh
# Midnight Tundra

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
put_template 0  "17/20/2a"
put_template 1  "d9/70/7c"
put_template 2  "7f/b8/8a"
put_template 3  "d8/b1/74"
put_template 4  "6d/a3/cf"
put_template 5  "a5/8c/c7"
put_template 6  "6f/b5/b8"
put_template 7  "ae/bc/cb"
put_template 8  "4f/62/72"
put_template 9  "e8/8a/95"
put_template 10 "99/cf/a3"
put_template 11 "e8/c8/8f"
put_template 12 "8a/bd/e4"
put_template 13 "bd/a6/dd"
put_template 14 "8c/ce/d0"
put_template 15 "e6/ee/f5"

color_foreground="c9/d4/de"
color_background="0e/14/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c9d4de"
  put_template_custom Ph "0e141b"
  put_template_custom Pi "c9d4de"
  put_template_custom Pj "24384a"
  put_template_custom Pk "e6eef5"
  put_template_custom Pl "8fb8d8"
  put_template_custom Pm "0e141b"
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
