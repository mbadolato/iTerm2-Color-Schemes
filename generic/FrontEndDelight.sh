#!/bin/sh
# FrontEndDelight

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
put_template 0  "24/25/26"
put_template 1  "f8/51/1b"
put_template 2  "56/57/47"
put_template 3  "fa/77/1d"
put_template 4  "2c/70/b7"
put_template 5  "f0/2e/4f"
put_template 6  "3c/a1/a6"
put_template 7  "ad/ad/ad"
put_template 8  "5f/ac/6d"
put_template 9  "f7/43/19"
put_template 10 "74/ec/4c"
put_template 11 "fd/c3/25"
put_template 12 "33/93/ca"
put_template 13 "e7/5e/4f"
put_template 14 "4f/bc/e6"
put_template 15 "8c/73/5b"

color_foreground="ad/ad/ad"
color_background="1b/1c/1d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "adadad"
  put_template_custom Ph "1b1c1d"
  put_template_custom Pi "cdcdcd"
  put_template_custom Pj "ea6154"
  put_template_custom Pk "1b1c1d"
  put_template_custom Pl "cdcdcd"
  put_template_custom Pm "1b1c1d"
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
