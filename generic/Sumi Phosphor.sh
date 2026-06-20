#!/bin/sh
# Sumi Phosphor

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
put_template 0  "1e/1a/16"
put_template 1  "d4/58/48"
put_template 2  "5c/a8/68"
put_template 3  "d4/a0/3c"
put_template 4  "5a/82/b8"
put_template 5  "98/70/b0"
put_template 6  "2e/c4/b6"
put_template 7  "8a/84/78"
put_template 8  "47/41/39"
put_template 9  "e8/70/60"
put_template 10 "72/c0/78"
put_template 11 "e8/b8/4c"
put_template 12 "70/a0/d8"
put_template 13 "b0/88/c8"
put_template 14 "48/d8/c8"
put_template 15 "e0/dc/d4"

color_foreground="ba/b4/a8"
color_background="12/10/0e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "bab4a8"
  put_template_custom Ph "12100e"
  put_template_custom Pi "e8e4dc"
  put_template_custom Pj "3a3834"
  put_template_custom Pk "e8e4dc"
  put_template_custom Pl "2ec4b6"
  put_template_custom Pm "12100e"
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
