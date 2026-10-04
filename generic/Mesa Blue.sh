#!/bin/sh
# Mesa Blue

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
put_template 0  "d3/d8/d5"
put_template 1  "ff/ad/91"
put_template 2  "9f/df/ad"
put_template 3  "f6/d6/7a"
put_template 4  "b7/d9/f4"
put_template 5  "ec/af/d4"
put_template 6  "a6/e5/df"
put_template 7  "ff/f0/d7"
put_template 8  "e1/e5/e2"
put_template 9  "ff/c0/a8"
put_template 10 "b9/e9/c2"
put_template 11 "ff/e5/96"
put_template 12 "ce/e6/f8"
put_template 13 "f3/c7/e0"
put_template 14 "c2/ef/ea"
put_template 15 "ff/fa/f0"

color_foreground="ff/f0/d7"
color_background="16/4c/72"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d7"
  put_template_custom Ph "164c72"
  put_template_custom Pi "ffb05f"
  put_template_custom Pj "35698b"
  put_template_custom Pk "fff8e9"
  put_template_custom Pl "ffc05d"
  put_template_custom Pm "164c72"
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
