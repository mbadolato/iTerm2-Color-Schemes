#!/bin/sh
# Barrel Cactus

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
put_template 0  "be/d0/c3"
put_template 1  "f5/a1/81"
put_template 2  "8b/d1/9b"
put_template 3  "ea/c9/5f"
put_template 4  "83/bf/d8"
put_template 5  "dc/aa/c8"
put_template 6  "77/d3/ca"
put_template 7  "ff/f0/d3"
put_template 8  "ce/db/d1"
put_template 9  "f8/ab/89"
put_template 10 "a3/dc/af"
put_template 11 "f3/d9/7f"
put_template 12 "9f/cf/e2"
put_template 13 "e4/b7/cf"
put_template 14 "96/df/d7"
put_template 15 "ff/f9/e9"

color_foreground="ff/f0/d3"
color_background="14/50/39"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d3"
  put_template_custom Ph "145039"
  put_template_custom Pi "f5c34e"
  put_template_custom Pj "326b56"
  put_template_custom Pk "fff8e6"
  put_template_custom Pl "f0bb4d"
  put_template_custom Pm "145039"
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
