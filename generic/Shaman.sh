#!/bin/sh
# Shaman

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
put_template 0  "01/20/26"
put_template 1  "b2/30/2d"
put_template 2  "00/a9/41"
put_template 3  "5e/8b/aa"
put_template 4  "44/9a/86"
put_template 5  "00/59/9d"
put_template 6  "5d/7e/19"
put_template 7  "40/55/55"
put_template 8  "38/44/51"
put_template 9  "ff/42/42"
put_template 10 "2a/ea/5e"
put_template 11 "8e/d4/fd"
put_template 12 "61/d5/ba"
put_template 13 "12/98/ff"
put_template 14 "98/d0/28"
put_template 15 "58/fb/d6"

color_foreground="40/55/55"
color_background="00/10/15"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "405555"
  put_template_custom Ph "001015"
  put_template_custom Pi "53fbd6"
  put_template_custom Pj "415555"
  put_template_custom Pk "5afad6"
  put_template_custom Pl "4afcd6"
  put_template_custom Pm "031413"
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
