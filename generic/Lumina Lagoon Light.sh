#!/bin/sh
# Lumina Lagoon Light

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
put_template 0  "0b/32/3b"
put_template 1  "8f/21/21"
put_template 2  "2e/61/47"
put_template 3  "a1/60/0d"
put_template 4  "18/5c/a9"
put_template 5  "89/49/84"
put_template 6  "00/6e/71"
put_template 7  "50/75/80"
put_template 8  "54/6f/74"
put_template 9  "68/22/20"
put_template 10 "00/50/31"
put_template 11 "87/4e/00"
put_template 12 "15/49/86"
put_template 13 "72/36/6e"
put_template 14 "00/58/5b"
put_template 15 "6f/95/a0"

color_foreground="0b/32/3b"
color_background="e9/fa/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "0b323b"
  put_template_custom Ph "e9fafa"
  put_template_custom Pi "0b323b"
  put_template_custom Pj "afd3d7"
  put_template_custom Pk "0b323b"
  put_template_custom Pl "0b323b"
  put_template_custom Pm "e9fafa"
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
