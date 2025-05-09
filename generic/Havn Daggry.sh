#!/bin/sh
# Havn Daggry

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
put_template 0  "21/28/40"
put_template 1  "8f/56/4b"
put_template 2  "5c/70/5b"
put_template 3  "b3/6f/00"
put_template 4  "40/56/7a"
put_template 5  "77/5d/93"
put_template 6  "8a/5a/7e"
put_template 7  "d7/db/ea"
put_template 8  "21/28/40"
put_template 9  "bd/53/3e"
put_template 10 "79/95/7b"
put_template 11 "f3/b5/50"
put_template 12 "69/88/bc"
put_template 13 "7b/73/93"
put_template 14 "a4/87/9c"
put_template 15 "d7/db/ea"

color_foreground="3e/4a/77"
color_background="f8/f9/fb"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3e4a77"
  put_template_custom Ph "f8f9fb"
  put_template_custom Pi "434d79"
  put_template_custom Pj "d4e8de"
  put_template_custom Pk "333c61"
  put_template_custom Pl "386a51"
  put_template_custom Pm "d7dbea"
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
