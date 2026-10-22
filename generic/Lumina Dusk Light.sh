#!/bin/sh
# Lumina Dusk Light

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
put_template 0  "3f/33/41"
put_template 1  "88/23/22"
put_template 2  "27/69/3a"
put_template 3  "64/4c/31"
put_template 4  "33/4f/9d"
put_template 5  "6f/2c/79"
put_template 6  "00/65/76"
put_template 7  "73/65/75"
put_template 8  "6e/60/73"
put_template 9  "62/22/20"
put_template 10 "12/55/29"
put_template 11 "59/35/00"
put_template 12 "28/3e/7a"
put_template 13 "53/25/59"
put_template 14 "00/50/5e"
put_template 15 "91/83/94"

color_foreground="3f/33/41"
color_background="f1/ea/f2"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3f3341"
  put_template_custom Ph "f1eaf2"
  put_template_custom Pi "3f3341"
  put_template_custom Pj "decee1"
  put_template_custom Pk "3f3341"
  put_template_custom Pl "3f3341"
  put_template_custom Pm "f1eaf2"
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
