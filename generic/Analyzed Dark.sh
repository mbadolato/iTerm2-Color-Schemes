#!/bin/sh
# Analyzed Dark

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
put_template 0  "83/95/a9"
put_template 1  "f0/78/8a"
put_template 2  "65/d5/ae"
put_template 3  "f2/c4/77"
put_template 4  "77/b9/f8"
put_template 5  "c2/a3/fa"
put_template 6  "5d/d5/d9"
put_template 7  "e7/ef/f8"
put_template 8  "9a/af/c5"
put_template 9  "ff/9b/ab"
put_template 10 "8a/eb/c5"
put_template 11 "ff/e0/9d"
put_template 12 "a1/ce/ff"
put_template 13 "d9/bd/ff"
put_template 14 "8a/f0/ee"
put_template 15 "ff/ff/ff"

color_foreground="e7/ef/f8"
color_background="0b/12/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e7eff8"
  put_template_custom Ph "0b1220"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "344b64"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "5dd5d9"
  put_template_custom Pm "0b1220"
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
