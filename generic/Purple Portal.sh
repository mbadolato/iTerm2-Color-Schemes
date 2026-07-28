#!/bin/sh
# Purple Portal

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
put_template 0  "48/3a/57"
put_template 1  "fb/71/85"
put_template 2  "34/d3/99"
put_template 3  "f4/72/b6"
put_template 4  "fa/cc/15"
put_template 5  "38/bd/f8"
put_template 6  "58/0f/f0"
put_template 7  "d8/b4/fe"
put_template 8  "50/38/72"
put_template 9  "fc/8d/9d"
put_template 10 "5d/dc/ad"
put_template 11 "f6/8b/c3"
put_template 12 "fb/d6/44"
put_template 13 "60/ca/f9"
put_template 14 "79/3f/f3"
put_template 15 "fa/f5/ff"

color_foreground="fa/f5/ff"
color_background="16/05/28"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "faf5ff"
  put_template_custom Ph "160528"
  put_template_custom Pi "faf5ff"
  put_template_custom Pj "faf5ff"
  put_template_custom Pk "160528"
  put_template_custom Pl "faf5ff"
  put_template_custom Pm "160528"
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
