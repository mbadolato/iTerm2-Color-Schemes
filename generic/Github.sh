#!/bin/sh
# Github

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
put_template 0  "3e/3e/3e"
put_template 1  "97/0b/16"
put_template 2  "07/96/2a"
put_template 3  "f8/ee/c7"
put_template 4  "00/3e/8a"
put_template 5  "e9/46/91"
put_template 6  "89/d1/ec"
put_template 7  "ff/ff/ff"
put_template 8  "66/66/66"
put_template 9  "de/00/00"
put_template 10 "87/d5/a2"
put_template 11 "f1/d0/07"
put_template 12 "2e/6c/ba"
put_template 13 "ff/a2/9f"
put_template 14 "1c/fa/fe"
put_template 15 "ff/ff/ff"

color_foreground="3e/3e/3e"
color_background="f4/f4/f4"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3e3e3e"
  put_template_custom Ph "f4f4f4"
  put_template_custom Pi "c95500"
  put_template_custom Pj "a9c1e2"
  put_template_custom Pk "535353"
  put_template_custom Pl "3f3f3f"
  put_template_custom Pm "f4f4f4"
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
