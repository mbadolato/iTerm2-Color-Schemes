#!/bin/sh
# Lumina Quartz Light

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
put_template 0  "30/35/3b"
put_template 1  "7d/2b/28"
put_template 2  "21/75/50"
put_template 3  "9a/64/2c"
put_template 4  "44/68/94"
put_template 5  "82/52/7e"
put_template 6  "00/70/92"
put_template 7  "6b/71/77"
put_template 8  "65/6b/72"
put_template 9  "5a/25/22"
put_template 10 "21/5e/41"
put_template 11 "82/51/1c"
put_template 12 "31/54/7e"
put_template 13 "6c/3f/69"
put_template 14 "11/5a/74"
put_template 15 "8a/90/97"

color_foreground="30/35/3b"
color_background="f5/f7/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "30353b"
  put_template_custom Ph "f5f7fa"
  put_template_custom Pi "30353b"
  put_template_custom Pj "bbbec1"
  put_template_custom Pk "30353b"
  put_template_custom Pl "30353b"
  put_template_custom Pm "f5f7fa"
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
