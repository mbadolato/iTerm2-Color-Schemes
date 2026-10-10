#!/bin/sh
# Harvest Moon

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
put_template 0  "b8/c2/c6"
put_template 1  "ee/99/7d"
put_template 2  "9b/ca/8e"
put_template 3  "ed/c6/67"
put_template 4  "8f/c1/dd"
put_template 5  "c7/a1/c8"
put_template 6  "80/ce/d0"
put_template 7  "ff/f1/d2"
put_template 8  "cb/d3/d6"
put_template 9  "f2/ae/92"
put_template 10 "b0/d6/a4"
put_template 11 "f4/d5/85"
put_template 12 "aa/d1/e7"
put_template 13 "d4/b8/d5"
put_template 14 "9e/db/dc"
put_template 15 "ff/f9/e8"

color_foreground="ff/f1/d2"
color_background="0d/35/57"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff1d2"
  put_template_custom Ph "0d3557"
  put_template_custom Pi "f7c45e"
  put_template_custom Pj "2a5371"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "f3b64a"
  put_template_custom Pm "0d3557"
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
