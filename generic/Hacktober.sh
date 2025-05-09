#!/bin/sh
# Hacktober

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
put_template 0  "19/19/18"
put_template 1  "b3/45/38"
put_template 2  "58/77/44"
put_template 3  "d0/89/49"
put_template 4  "20/6e/c5"
put_template 5  "86/46/51"
put_template 6  "ac/91/66"
put_template 7  "f1/ee/e7"
put_template 8  "2c/2b/2a"
put_template 9  "b3/33/23"
put_template 10 "42/82/4a"
put_template 11 "c7/5a/22"
put_template 12 "53/89/c5"
put_template 13 "e7/95/a5"
put_template 14 "eb/c5/87"
put_template 15 "ff/ff/ff"

color_foreground="c9/c9/c9"
color_background="14/14/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c9c9c9"
  put_template_custom Ph "141414"
  put_template_custom Pi "c9c9c9"
  put_template_custom Pj "141414"
  put_template_custom Pk "c9c9c9"
  put_template_custom Pl "c9c9c9"
  put_template_custom Pm "141414"
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
