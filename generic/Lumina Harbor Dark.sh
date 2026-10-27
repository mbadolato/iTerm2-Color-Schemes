#!/bin/sh
# Lumina Harbor Dark

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
put_template 0  "11/15/23"
put_template 1  "d0/75/6c"
put_template 2  "9b/d8/b4"
put_template 3  "ea/ce/8c"
put_template 4  "91/c5/ea"
put_template 5  "d3/a9/dd"
put_template 6  "91/cf/d6"
put_template 7  "bd/c1/ca"
put_template 8  "80/85/99"
put_template 9  "de/96/8e"
put_template 10 "b9/f1/d0"
put_template 11 "ff/e5/a9"
put_template 12 "b1/de/ff"
put_template 13 "eb/c4/f5"
put_template 14 "aa/e9/f0"
put_template 15 "dd/e1/eb"

color_foreground="dd/e1/eb"
color_background="0d/11/1d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dde1eb"
  put_template_custom Ph "0d111d"
  put_template_custom Pi "dde1eb"
  put_template_custom Pj "423139"
  put_template_custom Pk "dde1eb"
  put_template_custom Pl "dde1eb"
  put_template_custom Pm "0d111d"
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
