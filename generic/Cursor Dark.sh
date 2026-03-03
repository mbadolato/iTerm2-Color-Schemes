#!/bin/sh
# Cursor Dark

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
put_template 0  "24/24/24"
put_template 1  "fc/6b/83"
put_template 2  "3f/a2/66"
put_template 3  "d2/94/3e"
put_template 4  "81/a1/c1"
put_template 5  "b4/8e/ad"
put_template 6  "88/c0/d0"
put_template 7  "e4/e4/e4"
put_template 8  "4a/4a/4a"
put_template 9  "fc/6b/83"
put_template 10 "70/b4/89"
put_template 11 "f1/b4/67"
put_template 12 "87/a6/c4"
put_template 13 "b4/8e/ad"
put_template 14 "88/c0/d0"
put_template 15 "e4/e4/e4"

color_foreground="d4/d4/d4"
color_background="14/14/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d4d4d4"
  put_template_custom Ph "141414"
  put_template_custom Pi "d4d4d4"
  put_template_custom Pj "2c2c2c"
  put_template_custom Pk "e4e4e4"
  put_template_custom Pl "d4d4d4"
  put_template_custom Pm "141414"
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
