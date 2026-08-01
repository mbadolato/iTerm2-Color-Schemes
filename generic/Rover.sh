#!/bin/sh
# Rover

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
put_template 0  "14/1a/26"
put_template 1  "e2/70/7a"
put_template 2  "93/c9/a2"
put_template 3  "d9/b5/6b"
put_template 4  "6a/9f/d0"
put_template 5  "b4/9a/d8"
put_template 6  "5f/d0/e0"
put_template 7  "de/e5/ef"
put_template 8  "9d/ab/bd"
put_template 9  "ef/8b/93"
put_template 10 "ae/dc/ba"
put_template 11 "e8/c9/8a"
put_template 12 "8f/bc/e8"
put_template 13 "cb/b4/e6"
put_template 14 "8f/e4/f0"
put_template 15 "f4/f7/fb"

color_foreground="f5/f8/fd"
color_background="0a/0d/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5f8fd"
  put_template_custom Ph "0a0d14"
  put_template_custom Pi "f5f8fd"
  put_template_custom Pj "223047"
  put_template_custom Pk "f4f7fb"
  put_template_custom Pl "7fdcea"
  put_template_custom Pm "0a0d14"
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
