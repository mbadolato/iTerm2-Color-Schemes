#!/bin/sh
# Pueblo Night

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
put_template 0  "d5/ca/bd"
put_template 1  "fb/a1/83"
put_template 2  "94/d7/a5"
put_template 3  "f3/cf/6d"
put_template 4  "94/c9/ec"
put_template 5  "e4/aa/d2"
put_template 6  "87/dc/d6"
put_template 7  "ff/f0/d5"
put_template 8  "e3/d9/cd"
put_template 9  "ff/b6/9c"
put_template 10 "ab/e0/b8"
put_template 11 "ff/df/8d"
put_template 12 "b0/d7/f2"
put_template 13 "ed/c0/dd"
put_template 14 "a6/e7/e1"
put_template 15 "ff/fa/f0"

color_foreground="ff/f0/d5"
color_background="52/36/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d5"
  put_template_custom Ph "52361f"
  put_template_custom Pi "77dcd1"
  put_template_custom Pj "715039"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "f6bc55"
  put_template_custom Pm "52361f"
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
