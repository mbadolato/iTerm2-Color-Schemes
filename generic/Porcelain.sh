#!/bin/sh
# Porcelain

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
put_template 0  "2a/2e/37"
put_template 1  "c6/00/18"
put_template 2  "15/74/24"
put_template 3  "85/57/00"
put_template 4  "00/4c/c8"
put_template 5  "76/1b/c3"
put_template 6  "00/68/73"
put_template 7  "5a/61/70"
put_template 8  "82/88/96"
put_template 9  "d6/00/27"
put_template 10 "1b/84/2d"
put_template 11 "af/27/00"
put_template 12 "00/5b/db"
put_template 13 "86/2a/d2"
put_template 14 "00/7f/8f"
put_template 15 "1b/1e/25"

color_foreground="2a/2e/37"
color_background="fb/fb/fd"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2a2e37"
  put_template_custom Ph "fbfbfd"
  put_template_custom Pi "2a2e37"
  put_template_custom Pj "dce6f7"
  put_template_custom Pk "aeaeb0"
  put_template_custom Pl "0054d1"
  put_template_custom Pm "fbfbfd"
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
