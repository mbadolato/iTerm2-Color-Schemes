#!/bin/sh
# Gilded-Forest-Dark

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
put_template 0  "00/00/00"
put_template 1  "ec/6c/8b"
put_template 2  "a5/fc/af"
put_template 3  "f3/b4/6d"
put_template 4  "65/8c/f7"
put_template 5  "ae/7b/ff"
put_template 6  "72/be/f9"
put_template 7  "fc/fe/f9"
put_template 8  "65/56/56"
put_template 9  "b3/65/62"
put_template 10 "9d/ce/62"
put_template 11 "dd/d0/44"
put_template 12 "4e/ad/bd"
put_template 13 "75/1c/6c"
put_template 14 "54/ad/bd"
put_template 15 "fe/ff/ff"

color_foreground="f7/d2/7d"
color_background="0d/15/05"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7d27d"
  put_template_custom Ph "0d1505"
  put_template_custom Pi "f7d27d"
  put_template_custom Pj "282a73"
  put_template_custom Pk "f7d27d"
  put_template_custom Pl "f7d27d"
  put_template_custom Pm "0d1505"
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
