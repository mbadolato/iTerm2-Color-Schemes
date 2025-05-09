#!/bin/sh
# matrix

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
put_template 0  "0f/19/1c"
put_template 1  "23/75/5a"
put_template 2  "82/d9/67"
put_template 3  "ff/d7/00"
put_template 4  "3f/52/42"
put_template 5  "40/99/31"
put_template 6  "50/b4/5a"
put_template 7  "50/73/50"
put_template 8  "68/80/60"
put_template 9  "2f/c0/79"
put_template 10 "90/d7/62"
put_template 11 "fa/ff/00"
put_template 12 "4f/7e/7e"
put_template 13 "11/ff/25"
put_template 14 "c1/ff/8a"
put_template 15 "67/8c/61"

color_foreground="42/66/44"
color_background="0f/19/1c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "426644"
  put_template_custom Ph "0f191c"
  put_template_custom Pi "81b32c"
  put_template_custom Pj "18282e"
  put_template_custom Pk "00ff87"
  put_template_custom Pl "384545"
  put_template_custom Pm "00ff00"
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
