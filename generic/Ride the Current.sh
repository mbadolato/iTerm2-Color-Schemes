#!/bin/sh
# Ride the Current

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
put_template 0  "9a/af/bd"
put_template 1  "e7/78/7b"
put_template 2  "7d/c5/a6"
put_template 3  "e4/c4/76"
put_template 4  "79/b4/ff"
put_template 5  "ba/98/f4"
put_template 6  "6c/ce/e0"
put_template 7  "e0/f2/fc"
put_template 8  "b6/c8/d2"
put_template 9  "f3/94/9b"
put_template 10 "9e/d8/ba"
put_template 11 "f2/d5/90"
put_template 12 "a0/cc/ff"
put_template 13 "d0/b3/fa"
put_template 14 "90/e1/eb"
put_template 15 "f5/fc/ff"

color_foreground="e0/f2/fc"
color_background="04/1b/30"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0f2fc"
  put_template_custom Ph "041b30"
  put_template_custom Pi "f1faff"
  put_template_custom Pj "173e67"
  put_template_custom Pk "f1faff"
  put_template_custom Pl "58aaff"
  put_template_custom Pm "041b30"
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
