#!/bin/sh
# Nephrite Mint

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
put_template 0  "cb/e1/d4"
put_template 1  "ad/4b/4b"
put_template 2  "04/81/49"
put_template 3  "86/6c/02"
put_template 4  "26/72/b7"
put_template 5  "80/58/ab"
put_template 6  "01/7b/80"
put_template 7  "3f/52/47"
put_template 8  "60/72/68"
put_template 9  "ad/4b/4b"
put_template 10 "03/7e/65"
put_template 11 "86/6c/02"
put_template 12 "26/72/b7"
put_template 13 "a5/4a/77"
put_template 14 "01/7b/80"
put_template 15 "19/2e/23"

color_foreground="19/2e/23"
color_background="ed/fb/f3"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "192e23"
  put_template_custom Ph "edfbf3"
  put_template_custom Pi "192e23"
  put_template_custom Pj "bdd5c7"
  put_template_custom Pk "192e23"
  put_template_custom Pl "048149"
  put_template_custom Pm "edfbf3"
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
