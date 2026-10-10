#!/bin/sh
# Belfry

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
put_template 0  "bc/ae/b0"
put_template 1  "f1/81/7b"
put_template 2  "9d/cc/91"
put_template 3  "e7/c5/6d"
put_template 4  "91/bf/e0"
put_template 5  "d2/9a/c0"
put_template 6  "82/cb/c7"
put_template 7  "ff/f0/dc"
put_template 8  "d0/c3/c5"
put_template 9  "f5/9c/96"
put_template 10 "b2/d8/a7"
put_template 11 "ef/d5/8b"
put_template 12 "ac/cf/e8"
put_template 13 "df/b3/cf"
put_template 14 "a1/d9/d5"
put_template 15 "ff/fa/f0"

color_foreground="ff/f0/dc"
color_background="4a/0c/18"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0dc"
  put_template_custom Ph "4a0c18"
  put_template_custom Pi "f0c56a"
  put_template_custom Pj "702331"
  put_template_custom Pk "fff8eb"
  put_template_custom Pl "ef4858"
  put_template_custom Pm "4a0c18"
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
