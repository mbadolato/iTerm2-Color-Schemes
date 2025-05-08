#!/bin/sh
# jubi

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
put_template 0  "3b/37/50"
put_template 1  "cf/7b/98"
put_template 2  "90/a9/4b"
put_template 3  "6e/bf/c0"
put_template 4  "57/6e/a6"
put_template 5  "bc/4f/68"
put_template 6  "75/a7/d2"
put_template 7  "c3/d3/de"
put_template 8  "a8/74/ce"
put_template 9  "de/90/ab"
put_template 10 "bc/dd/61"
put_template 11 "87/e9/ea"
put_template 12 "8c/9f/cd"
put_template 13 "e1/6c/87"
put_template 14 "b7/c9/ef"
put_template 15 "d5/e5/f1"

color_foreground="c3/d3/de"
color_background="26/2b/33"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c3d3de"
  put_template_custom Ph "262b33"
  put_template_custom Pi "a874ce"
  put_template_custom Pj "5b5184"
  put_template_custom Pk "1e1b2e"
  put_template_custom Pl "c3d3de"
  put_template_custom Pm "1e1b2e"
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
