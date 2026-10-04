#!/bin/sh
# Ocotillo

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
put_template 0  "d8/c8/bc"
put_template 1  "ff/a0/8a"
put_template 2  "91/d6/a4"
put_template 3  "f4/cf/6c"
put_template 4  "95/c9/ed"
put_template 5  "e7/a8/d1"
put_template 6  "88/dd/d6"
put_template 7  "ff/f0/d8"
put_template 8  "e5/d6/cb"
put_template 9  "ff/b5/a0"
put_template 10 "aa/e0/b7"
put_template 11 "ff/df/8b"
put_template 12 "b1/d8/f3"
put_template 13 "ef/bf/db"
put_template 14 "a8/e8/e2"
put_template 15 "ff/fa/f0"

color_foreground="ff/f0/d8"
color_background="66/30/1e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d8"
  put_template_custom Ph "66301e"
  put_template_custom Pi "ffb25f"
  put_template_custom Pj "854b37"
  put_template_custom Pk "fff8e9"
  put_template_custom Pl "f7be55"
  put_template_custom Pm "66301e"
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
