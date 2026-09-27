#!/bin/sh
# EVH FrankenTone

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
put_template 0  "15/15/15"
put_template 1  "e1/06/00"
put_template 2  "8f/bd/32"
put_template 3  "ff/d4/00"
put_template 4  "2b/82/ff"
put_template 5  "ff/2d/6d"
put_template 6  "20/bd/e5"
put_template 7  "f4/f4/f4"
put_template 8  "47/47/47"
put_template 9  "ff/55/55"
put_template 10 "b8/e9/86"
put_template 11 "ff/e0/66"
put_template 12 "66/b3/ff"
put_template 13 "ff/8f/b1"
put_template 14 "22/d3/ee"
put_template 15 "f7/f7/f7"

color_foreground="e1/06/00"
color_background="0a/0a/0a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e10600"
  put_template_custom Ph "0a0a0a"
  put_template_custom Pi "f4f4f4"
  put_template_custom Pj "ff3b30"
  put_template_custom Pk "a6e22e"
  put_template_custom Pl "ffd400"
  put_template_custom Pm "2b82ff"
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
