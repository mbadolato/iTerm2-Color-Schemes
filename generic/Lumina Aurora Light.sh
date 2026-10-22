#!/bin/sh
# Lumina Aurora Light

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
put_template 0  "30/2a/3b"
put_template 1  "86/0e/23"
put_template 2  "00/6d/3c"
put_template 3  "9b/64/00"
put_template 4  "27/65/b0"
put_template 5  "9a/45/80"
put_template 6  "00/6d/80"
put_template 7  "73/6d/81"
put_template 8  "6b/65/78"
put_template 9  "5f/17/1e"
put_template 10 "00/57/2e"
put_template 11 "81/52/00"
put_template 12 "16/51/96"
put_template 13 "80/35/69"
put_template 14 "00/58/67"
put_template 15 "93/8c/a1"

color_foreground="30/2a/3b"
color_background="f7/f6/fb"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "302a3b"
  put_template_custom Ph "f7f6fb"
  put_template_custom Pi "302a3b"
  put_template_custom Pj "d4e0db"
  put_template_custom Pk "302a3b"
  put_template_custom Pl "302a3b"
  put_template_custom Pm "f7f6fb"
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
