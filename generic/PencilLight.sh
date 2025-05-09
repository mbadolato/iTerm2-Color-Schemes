#!/bin/sh
# PencilLight

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
put_template 0  "21/21/21"
put_template 1  "c3/07/71"
put_template 2  "10/a7/78"
put_template 3  "a8/9c/14"
put_template 4  "00/8e/c4"
put_template 5  "52/3c/79"
put_template 6  "20/a5/ba"
put_template 7  "d9/d9/d9"
put_template 8  "42/42/42"
put_template 9  "fb/00/7a"
put_template 10 "5f/d7/af"
put_template 11 "f3/e4/30"
put_template 12 "20/bb/fc"
put_template 13 "68/55/de"
put_template 14 "4f/b8/cc"
put_template 15 "f1/f1/f1"

color_foreground="42/42/42"
color_background="f1/f1/f1"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "424242"
  put_template_custom Ph "f1f1f1"
  put_template_custom Pi "fb007a"
  put_template_custom Pj "b6d6fd"
  put_template_custom Pk "424242"
  put_template_custom Pl "20bbfc"
  put_template_custom Pm "424242"
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
