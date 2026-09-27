#!/bin/sh
# Ozz's Blizzard

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
put_template 0  "26/32/44"
put_template 1  "e7/6f/6f"
put_template 2  "2a/9d/8f"
put_template 3  "8b/8b/4c"
put_template 4  "4c/c9/f0"
put_template 5  "7b/51/ff"
put_template 6  "ff/7a/b6"
put_template 7  "f7/f7/fa"
put_template 8  "5c/6b/7f"
put_template 9  "f8/71/71"
put_template 10 "34/d3/99"
put_template 11 "ff/cf/24"
put_template 12 "38/bd/ff"
put_template 13 "a7/8b/fa"
put_template 14 "22/d3/ee"
put_template 15 "f7/f7/fa"

color_foreground="3f/62/89"
color_background="0a/0f/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3f6289"
  put_template_custom Ph "0a0f1a"
  put_template_custom Pi "6f8fd9"
  put_template_custom Pj "e76f6f"
  put_template_custom Pk "6addcf"
  put_template_custom Pl "8b8b4c"
  put_template_custom Pm "4cc9f0"
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
