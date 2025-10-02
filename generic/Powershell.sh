#!/bin/sh
# Powershell

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
put_template 0  "00/00/00"
put_template 1  "98/1a/22"
put_template 2  "09/80/03"
put_template 3  "c4/a0/00"
put_template 4  "41/40/c3"
put_template 5  "d3/36/82"
put_template 6  "0e/80/7f"
put_template 7  "7f/7c/7f"
put_template 8  "80/80/80"
put_template 9  "ef/29/29"
put_template 10 "1c/fe/3c"
put_template 11 "fe/fe/45"
put_template 12 "26/8a/d2"
put_template 13 "fe/13/fa"
put_template 14 "29/ff/fe"
put_template 15 "c2/c1/c3"

color_foreground="f6/f6/f7"
color_background="05/24/54"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f6f6f7"
  put_template_custom Ph "052454"
  put_template_custom Pi "f6f6f7"
  put_template_custom Pj "f6f6f7"
  put_template_custom Pk "052454"
  put_template_custom Pl "f6f6f7"
  put_template_custom Pm "b6b6b7"
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
