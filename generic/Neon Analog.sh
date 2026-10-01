#!/bin/sh
# Neon Analog

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
put_template 0  "ae/b8/c7"
put_template 1  "ff/6b/9d"
put_template 2  "a8/d8/bc"
put_template 3  "f5/c1/4d"
put_template 4  "a8/c9/f2"
put_template 5  "d5/a6/f5"
put_template 6  "b8/e5/e8"
put_template 7  "e6/eb/f5"
put_template 8  "c1/ca/d6"
put_template 9  "ff/8a/b5"
put_template 10 "b9/e4/c9"
put_template 11 "f8/d3/6d"
put_template 12 "bd/d7/f7"
put_template 13 "df/bd/f7"
put_template 14 "c8/ee/f0"
put_template 15 "ff/ff/ff"

color_foreground="e6/eb/f5"
color_background="0b/0f/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6ebf5"
  put_template_custom Ph "0b0f14"
  put_template_custom Pi "ff00c8"
  put_template_custom Pj "1f2a3a"
  put_template_custom Pk "f5f8ff"
  put_template_custom Pl "00e5ff"
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
