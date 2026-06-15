#!/bin/sh
# Catppuccin Macchiato

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
put_template 0  "49/4d/64"
put_template 1  "ed/87/96"
put_template 2  "a6/da/95"
put_template 3  "ee/d4/9f"
put_template 4  "8a/ad/f4"
put_template 5  "f5/bd/e6"
put_template 6  "8b/d5/ca"
put_template 7  "b8/c0/e0"
put_template 8  "5b/60/78"
put_template 9  "f2/a7/b2"
put_template 10 "bd/e3/b0"
put_template 11 "f4/e3/c1"
put_template 12 "ad/c5/f7"
put_template 13 "f4/93/da"
put_template 14 "a5/de/d6"
put_template 15 "a5/ad/cb"

color_foreground="ca/d3/f5"
color_background="24/27/3a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cad3f5"
  put_template_custom Ph "24273a"
  put_template_custom Pi "cad3f5"
  put_template_custom Pj "f4dbd6"
  put_template_custom Pk "24273a"
  put_template_custom Pl "f4dbd6"
  put_template_custom Pm "24273a"
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
