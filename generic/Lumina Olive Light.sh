#!/bin/sh
# Lumina Olive Light

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
put_template 0  "26/28/16"
put_template 1  "86/1d/1d"
put_template 2  "29/70/3d"
put_template 3  "95/5e/00"
put_template 4  "2e/5b/a6"
put_template 5  "83/45/7e"
put_template 6  "00/6b/7d"
put_template 7  "6b/6d/59"
put_template 8  "6c/6e/5a"
put_template 9  "60/1e/1c"
put_template 10 "14/5b/2b"
put_template 11 "7b/4c/00"
put_template 12 "24/48/86"
put_template 13 "6d/32/68"
put_template 14 "00/56/64"
put_template 15 "89/8b/76"

color_foreground="26/28/16"
color_background="f1/f0/d9"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "262816"
  put_template_custom Ph "f1f0d9"
  put_template_custom Pi "262816"
  put_template_custom Pj "c8c3c3"
  put_template_custom Pk "262816"
  put_template_custom Pl "262816"
  put_template_custom Pm "f1f0d9"
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
