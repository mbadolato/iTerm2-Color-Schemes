#!/bin/sh
# Lumina Nebula Light

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
put_template 0  "2d/2c/46"
put_template 1  "93/22/22"
put_template 2  "00/76/50"
put_template 3  "95/5b/01"
put_template 4  "3f/57/77"
put_template 5  "89/48/84"
put_template 6  "01/6e/90"
put_template 7  "6d/6d/8b"
put_template 8  "67/66/80"
put_template 9  "6c/24/21"
put_template 10 "00/5f/40"
put_template 11 "7a/4a/00"
put_template 12 "0e/41/7f"
put_template 13 "72/35/6e"
put_template 14 "00/59/75"
put_template 15 "8c/8c/ab"

color_foreground="2d/2c/46"
color_background="f8/f4/ff"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2d2c46"
  put_template_custom Ph "f8f4ff"
  put_template_custom Pi "2d2c46"
  put_template_custom Pj "c7c7ef"
  put_template_custom Pk "2d2c46"
  put_template_custom Pl "2d2c46"
  put_template_custom Pm "f8f4ff"
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
