#!/bin/sh
# Grape

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
put_template 0  "2d/28/3f"
put_template 1  "ed/22/61"
put_template 2  "1f/a9/1b"
put_template 3  "8d/dc/20"
put_template 4  "48/7d/f4"
put_template 5  "8d/35/c9"
put_template 6  "3b/de/ed"
put_template 7  "9e/9e/a0"
put_template 8  "59/51/6a"
put_template 9  "f0/72/9a"
put_template 10 "53/aa/5e"
put_template 11 "b2/dc/87"
put_template 12 "a9/bc/ec"
put_template 13 "ad/81/c2"
put_template 14 "9d/e3/eb"
put_template 15 "a2/88/f7"

color_foreground="9f/9f/a1"
color_background="17/14/23"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "9f9fa1"
  put_template_custom Ph "171423"
  put_template_custom Pi "9f87ff"
  put_template_custom Pj "493d70"
  put_template_custom Pk "171422"
  put_template_custom Pl "a288f7"
  put_template_custom Pm "171422"
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
