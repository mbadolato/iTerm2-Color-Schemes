#!/bin/sh
# Monokai Vivid

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
put_template 0  "12/12/12"
put_template 1  "fa/29/34"
put_template 2  "98/e1/23"
put_template 3  "ff/f3/0a"
put_template 4  "04/43/ff"
put_template 5  "f8/00/f8"
put_template 6  "01/b6/ed"
put_template 7  "ff/ff/ff"
put_template 8  "83/83/83"
put_template 9  "f6/66/9d"
put_template 10 "b1/e0/5f"
put_template 11 "ff/f2/6d"
put_template 12 "04/43/ff"
put_template 13 "f2/00/f6"
put_template 14 "51/ce/ff"
put_template 15 "ff/ff/ff"

color_foreground="f9/f9/f9"
color_background="12/12/12"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f9f9f9"
  put_template_custom Ph "121212"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "ffffff"
  put_template_custom Pk "000000"
  put_template_custom Pl "fb0007"
  put_template_custom Pm "ea0009"
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
