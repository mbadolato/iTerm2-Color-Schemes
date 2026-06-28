#!/bin/sh
# Driftwood

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
put_template 0  "21/1d/19"
put_template 1  "e7/74/67"
put_template 2  "aa/b9/71"
put_template 3  "e1/b8/69"
put_template 4  "78/b3/b5"
put_template 5  "c9/a0/bd"
put_template 6  "a5/c4/b1"
put_template 7  "c2/b7/a6"
put_template 8  "9a/8e/7c"
put_template 9  "f3/8f/7e"
put_template 10 "be/cc/8a"
put_template 11 "e3/99/62"
put_template 12 "92/c6/c7"
put_template 13 "da/b6/d1"
put_template 14 "bb/d6/c3"
put_template 15 "f2/ea/db"

color_foreground="e6/dd/d0"
color_background="2a/26/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6ddd0"
  put_template_custom Ph "2a2622"
  put_template_custom Pi "e6ddd0"
  put_template_custom Pj "39332b"
  put_template_custom Pk "5d5955"
  put_template_custom Pl "dfb666"
  put_template_custom Pm "2a2622"
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
