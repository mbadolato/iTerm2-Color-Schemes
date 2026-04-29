#!/bin/sh
# Monokai SublimeText

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
put_template 0  "33/33/33"
put_template 1  "c4/26/5e"
put_template 2  "86/b4/2b"
put_template 3  "b3/b4/2b"
put_template 4  "6a/7e/c8"
put_template 5  "8c/6b/c8"
put_template 6  "56/ad/bc"
put_template 7  "e3/e3/dd"
put_template 8  "66/66/66"
put_template 9  "f9/26/72"
put_template 10 "a6/e2/2e"
put_template 11 "e2/e2/2e"
put_template 12 "81/9a/ff"
put_template 13 "ae/81/ff"
put_template 14 "66/d9/ef"
put_template 15 "f8/f8/f2"

color_foreground="f8/f8/f2"
color_background="27/28/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8f8f2"
  put_template_custom Ph "272822"
  put_template_custom Pi "f8f8f2"
  put_template_custom Pj "49483e"
  put_template_custom Pk "f8f8f2"
  put_template_custom Pl "f8f8f0"
  put_template_custom Pm "272822"
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
