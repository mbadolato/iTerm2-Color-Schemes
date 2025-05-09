#!/bin/sh
# wilmersdorf

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
put_template 0  "34/37/3e"
put_template 1  "e0/63/83"
put_template 2  "7e/be/bd"
put_template 3  "cc/cc/cc"
put_template 4  "a6/c1/e0"
put_template 5  "e1/c1/ee"
put_template 6  "5b/94/ab"
put_template 7  "ab/ab/ab"
put_template 8  "43/47/50"
put_template 9  "fa/71/93"
put_template 10 "8f/d7/d6"
put_template 11 "d1/df/ff"
put_template 12 "b2/cf/f0"
put_template 13 "ef/cc/fd"
put_template 14 "69/ab/c5"
put_template 15 "d3/d3/d3"

color_foreground="c6/c6/c6"
color_background="28/2b/33"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c6c6c6"
  put_template_custom Ph "282b33"
  put_template_custom Pi "c9d9ff"
  put_template_custom Pj "1f2024"
  put_template_custom Pk "c6c6c6"
  put_template_custom Pl "7ebebd"
  put_template_custom Pm "1f2024"
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
