#!/bin/sh
# Lumina Dusk Dark

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
put_template 0  "38/28/3a"
put_template 1  "dd/71/68"
put_template 2  "97/d2/a2"
put_template 3  "fa/d9/75"
put_template 4  "9e/c4/f7"
put_template 5  "e3/a0/f8"
put_template 6  "81/d1/da"
put_template 7  "c5/be/c7"
put_template 8  "a4/95/a9"
put_template 9  "e9/94/8c"
put_template 10 "b0/ed/bb"
put_template 11 "ff/e6/9e"
put_template 12 "c4/dd/ff"
put_template 13 "f1/c5/ff"
put_template 14 "9a/eb/f5"
put_template 15 "e6/de/e8"

color_foreground="e6/de/e8"
color_background="32/24/34"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6dee8"
  put_template_custom Ph "322434"
  put_template_custom Pi "e6dee8"
  put_template_custom Pj "5a4161"
  put_template_custom Pk "e6dee8"
  put_template_custom Pl "e6dee8"
  put_template_custom Pm "322434"
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
