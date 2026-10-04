#!/bin/sh
# Caliche

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
put_template 0  "c9/c4/b5"
put_template 1  "eb/ad/90"
put_template 2  "87/c7/9e"
put_template 3  "df/bf/68"
put_template 4  "91/c1/d6"
put_template 5  "d2/af/c4"
put_template 6  "76/c9/c4"
put_template 7  "ff/f0/d5"
put_template 8  "d8/d3/c5"
put_template 9  "ee/aa/89"
put_template 10 "99/d0/aa"
put_template 11 "e9/d0/87"
put_template 12 "9b/c9/dc"
put_template 13 "d8/b6/c8"
put_template 14 "94/d7/d2"
put_template 15 "ff/f9/e9"

color_foreground="ff/f0/d5"
color_background="55/45/2f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d5"
  put_template_custom Ph "55452f"
  put_template_custom Pi "e8b36f"
  put_template_custom Pj "74634c"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "f0bd5b"
  put_template_custom Pm "55452f"
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
