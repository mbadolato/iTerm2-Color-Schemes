#!/bin/sh
# Rhoads Tribute

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
put_template 0  "b9/ad/b9"
put_template 1  "ed/8b/8e"
put_template 2  "a9/cb/92"
put_template 3  "ea/c0/6a"
put_template 4  "a4/b9/e4"
put_template 5  "c3/a0/e5"
put_template 6  "8b/cd/d1"
put_template 7  "ff/f0/d2"
put_template 8  "d3/c8/d0"
put_template 9  "f6/a3/a2"
put_template 10 "c1/dd/a7"
put_template 11 "f5/d4/8a"
put_template 12 "b8/cb/ef"
put_template 13 "d8/b9/ef"
put_template 14 "a6/df/e1"
put_template 15 "ff/f9/ec"

color_foreground="ff/f0/d2"
color_background="29/21/2f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d2"
  put_template_custom Ph "29212f"
  put_template_custom Pi "efc66d"
  put_template_custom Pj "563a60"
  put_template_custom Pk "fff8e9"
  put_template_custom Pl "f2c36a"
  put_template_custom Pm "29212f"
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
