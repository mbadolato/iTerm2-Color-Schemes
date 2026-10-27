#!/bin/sh
# Lumina Aurora Light

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
put_template 0  "16/32/36"
put_template 1  "94/2a/28"
put_template 2  "02/6d/43"
put_template 3  "9f/61/16"
put_template 4  "42/5b/7a"
put_template 5  "89/4c/84"
put_template 6  "00/73/86"
put_template 7  "59/76/7b"
put_template 8  "55/6f/71"
put_template 9  "6d/29/26"
put_template 10 "00/57/34"
put_template 11 "86/4e/01"
put_template 12 "17/46/7d"
put_template 13 "73/3a/6e"
put_template 14 "00/5d/6d"
put_template 15 "77/95/9a"

color_foreground="16/32/36"
color_background="f2/fa/f9"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "163236"
  put_template_custom Ph "f2faf9"
  put_template_custom Pi "163236"
  put_template_custom Pj "b9d4c9"
  put_template_custom Pk "163236"
  put_template_custom Pl "163236"
  put_template_custom Pm "f2faf9"
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
