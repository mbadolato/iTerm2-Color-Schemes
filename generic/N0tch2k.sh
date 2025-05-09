#!/bin/sh
# N0tch2k

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
put_template 0  "38/38/38"
put_template 1  "a9/55/51"
put_template 2  "66/66/66"
put_template 3  "a9/80/51"
put_template 4  "65/7d/3e"
put_template 5  "76/76/76"
put_template 6  "c9/c9/c9"
put_template 7  "d0/b8/a3"
put_template 8  "47/47/47"
put_template 9  "a9/77/75"
put_template 10 "8c/8c/8c"
put_template 11 "a9/91/75"
put_template 12 "98/bd/5e"
put_template 13 "a3/a3/a3"
put_template 14 "dc/dc/dc"
put_template 15 "d8/c8/bb"

color_foreground="a0/a0/a0"
color_background="22/22/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "a0a0a0"
  put_template_custom Ph "222222"
  put_template_custom Pi "e5e5e5"
  put_template_custom Pj "4d4d4d"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "aa9175"
  put_template_custom Pm "000000"
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
