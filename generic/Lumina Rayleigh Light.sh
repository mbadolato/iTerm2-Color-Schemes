#!/bin/sh
# Lumina Rayleigh Light

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
put_template 0  "1d/26/38"
put_template 1  "94/14/19"
put_template 2  "18/75/38"
put_template 3  "9b/64/00"
put_template 4  "05/55/b7"
put_template 5  "a4/36/87"
put_template 6  "00/5c/71"
put_template 7  "67/73/88"
put_template 8  "65/6f/81"
put_template 9  "6b/1d/1b"
put_template 10 "00/5f/28"
put_template 11 "81/52/00"
put_template 12 "0a/44/90"
put_template 13 "81/32/6b"
put_template 14 "00/47/58"
put_template 15 "87/92/a9"

color_foreground="1d/26/38"
color_background="f7/fb/fe"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1d2638"
  put_template_custom Ph "f7fbfe"
  put_template_custom Pi "1d2638"
  put_template_custom Pj "bdcfee"
  put_template_custom Pk "1d2638"
  put_template_custom Pl "1d2638"
  put_template_custom Pm "f7fbfe"
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
