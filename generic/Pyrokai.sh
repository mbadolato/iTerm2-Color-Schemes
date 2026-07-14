#!/bin/sh
# Pyrokai

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
put_template 0  "24/21/20"
put_template 1  "ec/67/85"
put_template 2  "75/ad/2f"
put_template 3  "bb/95/00"
put_template 4  "2a/a0/f9"
put_template 5  "e7/68/99"
put_template 6  "00/ae/bd"
put_template 7  "b4/af/ad"
put_template 8  "80/7c/7a"
put_template 9  "fa/80/99"
put_template 10 "8b/bf/53"
put_template 11 "d0/a7/0e"
put_template 12 "5b/b3/ff"
put_template 13 "f6/81/ac"
put_template 14 "00/c3/d3"
put_template 15 "fa/f6/f5"

color_foreground="fa/f6/f5"
color_background="15/13/12"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "faf6f5"
  put_template_custom Ph "151312"
  put_template_custom Pi "faf6f5"
  put_template_custom Pj "312d2b"
  put_template_custom Pk "faf6f5"
  put_template_custom Pl "ea7332"
  put_template_custom Pm "151312"
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
