#!/bin/sh
# Lumina Aurora Dark

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
put_template 0  "17/10/22"
put_template 1  "d4/5f/58"
put_template 2  "53/e3/9c"
put_template 3  "fe/cc/74"
put_template 4  "b8/c5/e4"
put_template 5  "ee/aa/e7"
put_template 6  "75/d7/e2"
put_template 7  "b9/b5/c3"
put_template 8  "8a/81/9b"
put_template 9  "e0/84/7c"
put_template 10 "a2/f4/c4"
put_template 11 "ff/e4/b7"
put_template 12 "d2/df/ff"
put_template 13 "ff/cb/f9"
put_template 14 "8e/f2/fd"
put_template 15 "d9/d5/e3"

color_foreground="d9/d5/e3"
color_background="12/0c/1c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d9d5e3"
  put_template_custom Ph "120c1c"
  put_template_custom Pi "d9d5e3"
  put_template_custom Pj "263a3a"
  put_template_custom Pk "d9d5e3"
  put_template_custom Pl "d9d5e3"
  put_template_custom Pm "120c1c"
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
