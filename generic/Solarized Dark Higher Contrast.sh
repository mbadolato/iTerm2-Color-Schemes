#!/bin/sh
# Solarized Dark Higher Contrast

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
put_template 0  "00/28/31"
put_template 1  "d1/1c/24"
put_template 2  "6c/be/6c"
put_template 3  "a5/77/06"
put_template 4  "21/76/c7"
put_template 5  "c6/1c/6f"
put_template 6  "25/92/86"
put_template 7  "ea/e3/cb"
put_template 8  "00/64/88"
put_template 9  "f5/16/3b"
put_template 10 "51/ef/84"
put_template 11 "b2/7e/28"
put_template 12 "17/8e/c8"
put_template 13 "e2/4d/8e"
put_template 14 "00/b3/9e"
put_template 15 "fc/f4/dc"

color_foreground="9c/c2/c3"
color_background="00/1e/27"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "9cc2c3"
  put_template_custom Ph "001e27"
  put_template_custom Pi "b5d5d3"
  put_template_custom Pj "003748"
  put_template_custom Pk "7a8f8e"
  put_template_custom Pl "f34b00"
  put_template_custom Pm "002831"
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
