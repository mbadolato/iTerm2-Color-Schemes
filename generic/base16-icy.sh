#!/bin/sh
# base16-icy

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
put_template 0  "02/10/12"
put_template 1  "16/c2/d9"
put_template 2  "4d/d0/e1"
put_template 3  "80/de/ea"
put_template 4  "00/bc/d4"
put_template 5  "00/ad/c1"
put_template 6  "26/c6/d6"
put_template 7  "09/5b/67"
put_template 8  "1e/48/4e"
put_template 9  "b3/eb/f2"
put_template 10 "4d/d0/e1"
put_template 11 "80/de/ea"
put_template 12 "00/bc/d4"
put_template 13 "00/ad/c1"
put_template 14 "26/c6/d6"
put_template 15 "0c/7c/7c"

color_foreground="09/5b/67"
color_background="02/10/12"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "095b67"
  put_template_custom Ph "021012"
  put_template_custom Pi "095b67"
  put_template_custom Pj "041f23"
  put_template_custom Pk "425052"
  put_template_custom Pl "16c2d9"
  put_template_custom Pm "021012"
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
