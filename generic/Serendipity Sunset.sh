#!/bin/sh
# Serendipity Sunset

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
put_template 0  "36/38/47"
put_template 1  "d1/91/8f"
put_template 2  "70/9b/bd"
put_template 3  "a3/92/dc"
put_template 4  "a0/b6/e8"
put_template 5  "aa/c9/d4"
put_template 6  "d6/b4/b4"
put_template 7  "de/e0/ef"
put_template 8  "6b/6d/7c"
put_template 9  "d1/91/8f"
put_template 10 "70/9b/bd"
put_template 11 "a3/92/dc"
put_template 12 "a0/b6/e8"
put_template 13 "aa/c9/d4"
put_template 14 "d6/b4/b4"
put_template 15 "de/e0/ef"

color_foreground="de/e0/ef"
color_background="20/22/31"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dee0ef"
  put_template_custom Ph "202231"
  put_template_custom Pi "dee0ef"
  put_template_custom Pj "6b6d7c"
  put_template_custom Pk "dee0ef"
  put_template_custom Pl "8d8f9e"
  put_template_custom Pm "dee0ef"
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
