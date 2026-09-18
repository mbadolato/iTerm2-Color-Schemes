#!/bin/sh
# Lemon Graphite

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
put_template 0  "0b/0f/14"
put_template 1  "ff/6b/6b"
put_template 2  "7b/d8/8f"
put_template 3  "f2/c1/4e"
put_template 4  "5c/c8/ff"
put_template 5  "c7/92/ea"
put_template 6  "57/d3/c8"
put_template 7  "dc/e3/ea"
put_template 8  "59/63/6e"
put_template 9  "ff/8a/80"
put_template 10 "a7/e8/b5"
put_template 11 "ff/d9/78"
put_template 12 "8a/d8/ff"
put_template 13 "da/b1/f4"
put_template 14 "86/e6/de"
put_template 15 "f7/fa/fc"

color_foreground="dc/e3/ea"
color_background="0b/0f/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dce3ea"
  put_template_custom Ph "0b0f14"
  put_template_custom Pi "dce3ea"
  put_template_custom Pj "dce3ea"
  put_template_custom Pk "0b0f14"
  put_template_custom Pl "f2c14e"
  put_template_custom Pm "0b0f14"
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
