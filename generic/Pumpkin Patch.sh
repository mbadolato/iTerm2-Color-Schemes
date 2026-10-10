#!/bin/sh
# Pumpkin Patch

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
put_template 0  "c3/c8/af"
put_template 1  "f0/98/70"
put_template 2  "95/ce/77"
put_template 3  "e8/c9/5a"
put_template 4  "87/bf/cf"
put_template 5  "c7/9a/b7"
put_template 6  "79/c9/bb"
put_template 7  "f5/ef/d1"
put_template 8  "ca/cf/b9"
put_template 9  "f2/a4/81"
put_template 10 "a2/d4/87"
put_template 11 "eb/cf/6e"
put_template 12 "95/c7/d5"
put_template 13 "ce/a6/c0"
put_template 14 "89/cf/c3"
put_template 15 "f6/f1/d7"

color_foreground="f5/ef/d1"
color_background="24/34/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5efd1"
  put_template_custom Ph "243416"
  put_template_custom Pi "ebcf6e"
  put_template_custom Pj "cacfb9"
  put_template_custom Pk "9d987e"
  put_template_custom Pl "f2a481"
  put_template_custom Pm "243416"
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
