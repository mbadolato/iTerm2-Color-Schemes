#!/bin/sh
# arcoiris

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
put_template 0  "33/33/33"
put_template 1  "da/27/00"
put_template 2  "12/c2/58"
put_template 3  "ff/c6/56"
put_template 4  "51/8b/fc"
put_template 5  "e3/7b/d9"
put_template 6  "63/fa/d5"
put_template 7  "ba/b2/b2"
put_template 8  "77/77/77"
put_template 9  "ff/b9/b9"
put_template 10 "e3/f6/aa"
put_template 11 "ff/dd/aa"
put_template 12 "b3/e8/f3"
put_template 13 "cb/ba/f9"
put_template 14 "bc/ff/c7"
put_template 15 "ef/ef/ef"

color_foreground="ee/e4/d9"
color_background="20/1f/1e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eee4d9"
  put_template_custom Ph "201f1e"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "25524a"
  put_template_custom Pk "f3fffd"
  put_template_custom Pl "7a1c1c"
  put_template_custom Pm "fffbf2"
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
