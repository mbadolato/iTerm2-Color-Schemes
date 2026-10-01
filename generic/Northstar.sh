#!/bin/sh
# Northstar

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
put_template 0  "ae/b6/c2"
put_template 1  "ff/6f/73"
put_template 2  "6e/d9/9a"
put_template 3  "f7/d6/6d"
put_template 4  "7e/a8/ff"
put_template 5  "d7/9a/f4"
put_template 6  "70/dc/e8"
put_template 7  "ee/f2/f7"
put_template 8  "c1/c7/d0"
put_template 9  "ff/8b/8e"
put_template 10 "8a/e3/ad"
put_template 11 "ff/e3/8b"
put_template 12 "9b/bc/ff"
put_template 13 "e5/b0/f8"
put_template 14 "91/e7/ef"
put_template 15 "ff/ff/ff"

color_foreground="f5/f7/fb"
color_background="0b/0f/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5f7fb"
  put_template_custom Ph "0b0f1a"
  put_template_custom Pi "ffcf4a"
  put_template_custom Pj "1f2937"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "fcd34d"
  put_template_custom Pm "0b0f1a"
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
