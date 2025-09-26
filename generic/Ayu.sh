#!/bin/sh
# Ayu

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
put_template 0  "11/15/1c"
put_template 1  "ea/6c/73"
put_template 2  "7f/d9/62"
put_template 3  "f9/af/4f"
put_template 4  "53/bd/fa"
put_template 5  "cd/a1/fa"
put_template 6  "90/e1/c6"
put_template 7  "c7/c7/c7"
put_template 8  "68/68/68"
put_template 9  "f0/71/78"
put_template 10 "aa/d9/4c"
put_template 11 "ff/b4/54"
put_template 12 "59/c2/ff"
put_template 13 "d2/a6/ff"
put_template 14 "95/e6/cb"
put_template 15 "ff/ff/ff"

color_foreground="bf/bd/b6"
color_background="0b/0e/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "bfbdb6"
  put_template_custom Ph "0b0e14"
  put_template_custom Pi "bfbdb6"
  put_template_custom Pj "409fff"
  put_template_custom Pk "0b0e14"
  put_template_custom Pl "e6b450"
  put_template_custom Pm "0b0e14"
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
