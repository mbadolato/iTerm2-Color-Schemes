#!/bin/sh
# Monokai Pro

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
put_template 0  "2d/2a/2e"
put_template 1  "ff/61/88"
put_template 2  "a9/dc/76"
put_template 3  "ff/d8/66"
put_template 4  "fc/98/67"
put_template 5  "ab/9d/f2"
put_template 6  "78/dc/e8"
put_template 7  "fc/fc/fa"
put_template 8  "72/70/72"
put_template 9  "ff/61/88"
put_template 10 "a9/dc/76"
put_template 11 "ff/d8/66"
put_template 12 "fc/98/67"
put_template 13 "ab/9d/f2"
put_template 14 "78/dc/e8"
put_template 15 "fc/fc/fa"

color_foreground="fc/fc/fa"
color_background="2d/2a/2e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fcfcfa"
  put_template_custom Ph "2d2a2e"
  put_template_custom Pi "78dce8"
  put_template_custom Pj "5b595c"
  put_template_custom Pk "fcfcfa"
  put_template_custom Pl "c1c0c0"
  put_template_custom Pm "c1c0c0"
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
