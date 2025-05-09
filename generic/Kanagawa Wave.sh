#!/bin/sh
# Kanagawa Wave

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
put_template 0  "09/06/18"
put_template 1  "c3/40/43"
put_template 2  "76/94/6a"
put_template 3  "c0/a3/6e"
put_template 4  "7e/9c/d8"
put_template 5  "95/7f/b8"
put_template 6  "6a/95/89"
put_template 7  "c8/c0/93"
put_template 8  "72/71/69"
put_template 9  "e8/24/24"
put_template 10 "98/bb/6c"
put_template 11 "e6/c3/84"
put_template 12 "7f/b4/ca"
put_template 13 "93/8a/a9"
put_template 14 "7a/a8/9f"
put_template 15 "dc/d7/ba"

color_foreground="dc/d7/ba"
color_background="1f/1f/28"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dcd7ba"
  put_template_custom Ph "1f1f28"
  put_template_custom Pi "eeeeee"
  put_template_custom Pj "2d4f67"
  put_template_custom Pk "c8c093"
  put_template_custom Pl "c8c093"
  put_template_custom Pm "1d202f"
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
