#!/bin/sh
# Last Broadcast

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
put_template 0  "b7/b5/b0"
put_template 1  "ff/80/6f"
put_template 2  "79/d0/9e"
put_template 3  "ef/cb/69"
put_template 4  "8b/b4/ed"
put_template 5  "d5/a2/e5"
put_template 6  "80/d3/da"
put_template 7  "f2/ef/e8"
put_template 8  "ca/c7/c1"
put_template 9  "ff/9c/8d"
put_template 10 "99/dd/b5"
put_template 11 "f6/dc/8b"
put_template 12 "aa/c9/f3"
put_template 13 "e4/bb/ed"
put_template 14 "a2/e1/e5"
put_template 15 "ff/fd/f8"

color_foreground="f2/ef/e8"
color_background="08/09/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2efe8"
  put_template_custom Ph "08090d"
  put_template_custom Pi "ffb454"
  put_template_custom Pj "30281d"
  put_template_custom Pk "fff8eb"
  put_template_custom Pl "ffca72"
  put_template_custom Pm "08090d"
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
