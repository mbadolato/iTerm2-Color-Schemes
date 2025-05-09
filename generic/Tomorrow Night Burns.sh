#!/bin/sh
# Tomorrow Night Burns

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
put_template 0  "25/25/25"
put_template 1  "83/2e/31"
put_template 2  "a6/3c/40"
put_template 3  "d3/49/4e"
put_template 4  "fc/59/5f"
put_template 5  "df/93/95"
put_template 6  "ba/85/86"
put_template 7  "f5/f5/f5"
put_template 8  "5d/6f/71"
put_template 9  "83/2e/31"
put_template 10 "a6/3c/40"
put_template 11 "d2/49/4e"
put_template 12 "fc/59/5f"
put_template 13 "df/93/95"
put_template 14 "ba/85/86"
put_template 15 "f5/f5/f5"

color_foreground="a1/b0/b8"
color_background="15/15/15"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "a1b0b8"
  put_template_custom Ph "151515"
  put_template_custom Pi "819090"
  put_template_custom Pj "b0bec5"
  put_template_custom Pk "2a2d32"
  put_template_custom Pl "ff443e"
  put_template_custom Pm "708284"
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
