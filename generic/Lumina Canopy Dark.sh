#!/bin/sh
# Lumina Canopy Dark

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
put_template 0  "17/22/1a"
put_template 1  "d3/66/5e"
put_template 2  "96/d4/a2"
put_template 3  "f2/bb/31"
put_template 4  "8d/c6/ff"
put_template 5  "d1/a5/d3"
put_template 6  "8c/e3/dd"
put_template 7  "ad/bb/b0"
put_template 8  "7b/93/81"
put_template 9  "df/89/81"
put_template 10 "ae/ef/bb"
put_template 11 "ff/d9/89"
put_template 12 "be/de/ff"
put_template 13 "f2/b9/f5"
put_template 14 "a1/fb/f5"
put_template 15 "cd/db/d0"

color_foreground="cd/db/d0"
color_background="13/1d/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cddbd0"
  put_template_custom Ph "131d16"
  put_template_custom Pi "cddbd0"
  put_template_custom Pj "434022"
  put_template_custom Pk "cddbd0"
  put_template_custom Pl "cddbd0"
  put_template_custom Pm "131d16"
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
