#!/bin/sh
# Galizur

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
put_template 0  "22/33/44"
put_template 1  "aa/11/22"
put_template 2  "33/aa/11"
put_template 3  "cc/aa/22"
put_template 4  "22/55/cc"
put_template 5  "77/55/aa"
put_template 6  "22/bb/dd"
put_template 7  "88/99/aa"
put_template 8  "55/66/77"
put_template 9  "ff/11/33"
put_template 10 "33/ff/11"
put_template 11 "ff/dd/33"
put_template 12 "33/77/ff"
put_template 13 "aa/77/ff"
put_template 14 "33/dd/ff"
put_template 15 "bb/cc/dd"

color_foreground="dd/ee/ff"
color_background="07/13/17"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ddeeff"
  put_template_custom Ph "071317"
  put_template_custom Pi "ddeeff"
  put_template_custom Pj "071317"
  put_template_custom Pk "ddeeff"
  put_template_custom Pl "ddeeff"
  put_template_custom Pm "071317"
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
