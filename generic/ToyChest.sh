#!/bin/sh
# ToyChest

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
put_template 0  "2c/3f/58"
put_template 1  "be/2d/26"
put_template 2  "1a/91/72"
put_template 3  "db/8e/27"
put_template 4  "32/5d/96"
put_template 5  "8a/5e/dc"
put_template 6  "35/a0/8f"
put_template 7  "23/d1/83"
put_template 8  "33/68/89"
put_template 9  "dd/59/44"
put_template 10 "31/d0/7b"
put_template 11 "e7/d8/4b"
put_template 12 "34/a6/da"
put_template 13 "ae/6b/dc"
put_template 14 "42/c3/ae"
put_template 15 "d5/d5/d5"

color_foreground="31/d0/7b"
color_background="24/36/4b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "31d07b"
  put_template_custom Ph "24364b"
  put_template_custom Pi "2bff9f"
  put_template_custom Pj "5f217a"
  put_template_custom Pk "d5d5d5"
  put_template_custom Pl "d5d5d5"
  put_template_custom Pm "141c25"
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
