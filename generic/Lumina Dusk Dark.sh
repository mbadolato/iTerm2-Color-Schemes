#!/bin/sh
# Lumina Dusk Dark

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
put_template 0  "1f/1c/2b"
put_template 1  "d0/74/6c"
put_template 2  "a0/d1/a9"
put_template 3  "ef/cb/7b"
put_template 4  "9b/be/f2"
put_template 5  "e1/b0/dc"
put_template 6  "90/cf/d7"
put_template 7  "c0/bc/c9"
put_template 8  "8a/84/99"
put_template 9  "de/95/8d"
put_template 10 "b9/ec/c2"
put_template 11 "ff/e5/ad"
put_template 12 "bd/d8/ff"
put_template 13 "fc/c9/f7"
put_template 14 "a9/e9/f2"
put_template 15 "e0/dc/ea"

color_foreground="e0/dc/ea"
color_background="1a/18/25"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0dcea"
  put_template_custom Ph "1a1825"
  put_template_custom Pi "e0dcea"
  put_template_custom Pj "4c373f"
  put_template_custom Pk "e0dcea"
  put_template_custom Pl "e0dcea"
  put_template_custom Pm "1a1825"
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
