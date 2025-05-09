#!/bin/sh
# zenburned

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
put_template 0  "40/40/40"
put_template 1  "e3/71/6e"
put_template 2  "81/9b/69"
put_template 3  "b7/7e/64"
put_template 4  "60/99/c0"
put_template 5  "b2/79/a7"
put_template 6  "66/a5/ad"
put_template 7  "f0/e4/cf"
put_template 8  "62/5a/5b"
put_template 9  "ec/86/85"
put_template 10 "8b/ae/68"
put_template 11 "d6/8c/67"
put_template 12 "61/ab/da"
put_template 13 "cf/86/c1"
put_template 14 "65/b8/c1"
put_template 15 "c0/ab/86"

color_foreground="f0/e4/cf"
color_background="40/40/40"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f0e4cf"
  put_template_custom Ph "404040"
  put_template_custom Pi "625a5b"
  put_template_custom Pj "746956"
  put_template_custom Pk "f0e4cf"
  put_template_custom Pl "f3eadb"
  put_template_custom Pm "404040"
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
