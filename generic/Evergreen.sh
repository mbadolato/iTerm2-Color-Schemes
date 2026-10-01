#!/bin/sh
# Evergreen

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
put_template 0  "ae/bf/b6"
put_template 1  "ff/8a/82"
put_template 2  "82/d6/a5"
put_template 3  "f0/d1/6e"
put_template 4  "8b/b8/ee"
put_template 5  "d6/a5/e5"
put_template 6  "82/d7/d2"
put_template 7  "e9/f7/ef"
put_template 8  "c5/d1/cb"
put_template 9  "ff/a2/9b"
put_template 10 "a2/e2/bc"
put_template 11 "f6/df/90"
put_template 12 "ab/cd/f4"
put_template 13 "e5/bf/ed"
put_template 14 "a3/e5/e0"
put_template 15 "ff/ff/ff"

color_foreground="e9/f7/ef"
color_background="03/2b/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e9f7ef"
  put_template_custom Ph "032b1b"
  put_template_custom Pi "72e6a0"
  put_template_custom Pj "18553a"
  put_template_custom Pk "f3fff7"
  put_template_custom Pl "7cf0ad"
  put_template_custom Pm "032b1b"
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
