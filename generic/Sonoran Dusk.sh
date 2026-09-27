#!/bin/sh
# Sonoran Dusk

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
put_template 0  "2d/24/33"
put_template 1  "e7/6f/51"
put_template 2  "8a/bf/7f"
put_template 3  "e9/c4/6a"
put_template 4  "5d/ad/e2"
put_template 5  "c6/78/dd"
put_template 6  "2d/d4/bf"
put_template 7  "e8/e2/d1"
put_template 8  "6b/72/80"
put_template 9  "ff/8a/65"
put_template 10 "a6/e3/a1"
put_template 11 "ff/d1/66"
put_template 12 "7e/c8/f8"
put_template 13 "d4/8c/ff"
put_template 14 "52/e6/d6"
put_template 15 "ff/f1/d6"

color_foreground="e8/e1/d9"
color_background="1a/0f/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8e1d9"
  put_template_custom Ph "1a0f24"
  put_template_custom Pi "c9b6a4"
  put_template_custom Pj "3a2a45"
  put_template_custom Pk "e8e1d9"
  put_template_custom Pl "f4a261"
  put_template_custom Pm "1a0f24"
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
