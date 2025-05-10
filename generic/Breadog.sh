#!/bin/sh
# Breadog

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
put_template 0  "36/2c/24"
put_template 1  "b1/0b/00"
put_template 2  "00/72/32"
put_template 3  "8b/4c/00"
put_template 4  "00/5c/b4"
put_template 5  "9b/00/97"
put_template 6  "00/6a/78"
put_template 7  "d4/c3/b7"
put_template 8  "51/43/37"
put_template 9  "de/11/00"
put_template 10 "00/8f/40"
put_template 11 "ae/60/00"
put_template 12 "00/74/e1"
put_template 13 "c3/00/bd"
put_template 14 "00/86/97"
put_template 15 "ea/e1/da"

color_foreground="36/2c/24"
color_background="f1/eb/e6"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "362c24"
  put_template_custom Ph "f1ebe6"
  put_template_custom Pi "362c24"
  put_template_custom Pj "362c24"
  put_template_custom Pk "f1ebe6"
  put_template_custom Pl "362c24"
  put_template_custom Pm "f1ebe6"
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
