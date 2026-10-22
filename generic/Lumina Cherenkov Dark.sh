#!/bin/sh
# Lumina Cherenkov Dark

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
put_template 0  "0e/15/25"
put_template 1  "da/61/59"
put_template 2  "8b/d2/9a"
put_template 3  "e0/b9/55"
put_template 4  "c4/db/ed"
put_template 5  "e7/a3/e0"
put_template 6  "6a/d0/db"
put_template 7  "b0/bc/c8"
put_template 8  "79/87/9c"
put_template 9  "e5/86/7e"
put_template 10 "a4/ed/b2"
put_template 11 "fc/d3/6b"
put_template 12 "d3/ec/ff"
put_template 13 "ff/bf/f8"
put_template 14 "84/ea/f6"
put_template 15 "d0/dc/e9"

color_foreground="d0/dc/e9"
color_background="0a/11/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d0dce9"
  put_template_custom Ph "0a111f"
  put_template_custom Pi "d0dce9"
  put_template_custom Pj "252f52"
  put_template_custom Pk "d0dce9"
  put_template_custom Pl "d0dce9"
  put_template_custom Pm "0a111f"
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
