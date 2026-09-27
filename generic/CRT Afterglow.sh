#!/bin/sh
# CRT Afterglow

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
put_template 0  "20/30/20"
put_template 1  "ff/5f/56"
put_template 2  "50/fa/7b"
put_template 3  "f1/fa/8c"
put_template 4  "8b/e9/fd"
put_template 5  "bd/93/f9"
put_template 6  "5a/f7/8e"
put_template 7  "95/a9/9b"
put_template 8  "4a/5d/4a"
put_template 9  "ff/8a/80"
put_template 10 "8a/ff/9d"
put_template 11 "ff/f5/9d"
put_template 12 "b3/f1/ff"
put_template 13 "dd/a0/ff"
put_template 14 "8a/ff/d8"
put_template 15 "f5/f7/ef"

color_foreground="d0/d8/c8"
color_background="0b/0f/0b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d0d8c8"
  put_template_custom Ph "0b0f0b"
  put_template_custom Pi "1e2d1e"
  put_template_custom Pj "2a3a2a"
  put_template_custom Pk "d0d8c8"
  put_template_custom Pl "f4d35e"
  put_template_custom Pm "0b0f0b"
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
