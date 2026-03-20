#!/bin/sh
# Karasu Night

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
put_template 0  "0a/0a/0a"
put_template 1  "e0/6c/75"
put_template 2  "8f/bf/7a"
put_template 3  "d4/b8/6a"
put_template 4  "7a/a2/c8"
put_template 5  "b4/a1/d8"
put_template 6  "76/b7/b2"
put_template 7  "f5/f5/f5"
put_template 8  "44/40/3c"
put_template 9  "ff/5c/5c"
put_template 10 "a6/d1/89"
put_template 11 "e8/d0/7d"
put_template 12 "8c/b4/e2"
put_template 13 "c7/b3/ee"
put_template 14 "8a/d4/ce"
put_template 15 "e7/e5/e4"

color_foreground="e7/e5/e4"
color_background="0a/0a/0a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e7e5e4"
  put_template_custom Ph "0a0a0a"
  put_template_custom Pi "e7e5e4"
  put_template_custom Pj "262626"
  put_template_custom Pk "e7e5e4"
  put_template_custom Pl "f5f5f5"
  put_template_custom Pm "0a0a0a"
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
