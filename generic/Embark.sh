#!/bin/sh
# Embark

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
put_template 0  "1e/1c/31"
put_template 1  "f0/71/9b"
put_template 2  "a1/ef/d3"
put_template 3  "ff/e9/aa"
put_template 4  "57/c7/ff"
put_template 5  "c7/92/ea"
put_template 6  "87/df/eb"
put_template 7  "f8/f8/f2"
put_template 8  "58/52/73"
put_template 9  "f0/2e/6e"
put_template 10 "2c/e5/92"
put_template 11 "ff/b3/78"
put_template 12 "1d/a0/e2"
put_template 13 "a7/42/ea"
put_template 14 "63/f2/f1"
put_template 15 "a6/b3/cc"

color_foreground="ee/ff/ff"
color_background="1e/1c/31"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eeffff"
  put_template_custom Ph "1e1c31"
  put_template_custom Pi "c4c9ff"
  put_template_custom Pj "fbfcfc"
  put_template_custom Pk "1e1c31"
  put_template_custom Pl "a1efd3"
  put_template_custom Pm "1e1c31"
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
