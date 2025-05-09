#!/bin/sh
# Red Planet

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
put_template 0  "20/20/20"
put_template 1  "8c/34/32"
put_template 2  "72/82/71"
put_template 3  "e8/bf/6a"
put_template 4  "69/81/9e"
put_template 5  "89/64/92"
put_template 6  "5b/83/90"
put_template 7  "b9/aa/99"
put_template 8  "67/67/67"
put_template 9  "b5/52/42"
put_template 10 "86/99/85"
put_template 11 "eb/eb/91"
put_template 12 "60/82/7e"
put_template 13 "de/49/74"
put_template 14 "38/ad/d8"
put_template 15 "d6/bf/b8"

color_foreground="c2/b7/90"
color_background="22/22/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c2b790"
  put_template_custom Ph "222222"
  put_template_custom Pi "ebeb91"
  put_template_custom Pj "1b324a"
  put_template_custom Pk "bcb291"
  put_template_custom Pl "c2b790"
  put_template_custom Pm "202020"
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
