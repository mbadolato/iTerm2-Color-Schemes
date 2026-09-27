#!/bin/sh
# Emberglass

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
put_template 0  "2a/2f/36"
put_template 1  "f9/73/16"
put_template 2  "22/c5/5e"
put_template 3  "ea/b3/08"
put_template 4  "38/bd/f8"
put_template 5  "a8/55/f7"
put_template 6  "14/b8/a6"
put_template 7  "cb/d5/e1"
put_template 8  "64/74/8b"
put_template 9  "fb/92/3c"
put_template 10 "86/ef/ac"
put_template 11 "fa/cc/15"
put_template 12 "7d/d3/fc"
put_template 13 "c0/84/fc"
put_template 14 "67/e8/f9"
put_template 15 "f1/f5/f9"

color_foreground="e6/e7/eb"
color_background="0b/0e/11"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e7eb"
  put_template_custom Ph "0b0e11"
  put_template_custom Pi "a3a4a6"
  put_template_custom Pj "4b5563"
  put_template_custom Pk "e8e7e3"
  put_template_custom Pl "f59e0b"
  put_template_custom Pm "0b0e11"
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
