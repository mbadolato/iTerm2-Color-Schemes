#!/bin/sh
# Royal Rhapsody

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
put_template 0  "68/5c/59"
put_template 1  "84/33/44"
put_template 2  "38/6f/55"
put_template 3  "73/54/17"
put_template 4  "2b/53/7b"
put_template 5  "6d/44/6f"
put_template 6  "29/68/6c"
put_template 7  "2d/2b/3b"
put_template 8  "53/4a/47"
put_template 9  "74/2d/3c"
put_template 10 "31/62/4b"
put_template 11 "65/4a/14"
put_template 12 "26/49/6c"
put_template 13 "60/3c/62"
put_template 14 "24/5c/5f"
put_template 15 "24/22/2f"

color_foreground="2d/2b/3b"
color_background="f0/e6/d8"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2d2b3b"
  put_template_custom Ph "f0e6d8"
  put_template_custom Pi "24222f"
  put_template_custom Pj "dbc7c3"
  put_template_custom Pk "2d2b3b"
  put_template_custom Pl "654a14"
  put_template_custom Pm "f0e6d8"
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
