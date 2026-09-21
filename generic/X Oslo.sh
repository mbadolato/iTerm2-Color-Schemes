#!/bin/sh
# X Oslo

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
put_template 0  "3f/44/51"
put_template 1  "e0/55/61"
put_template 2  "8c/c2/65"
put_template 3  "d1/8f/52"
put_template 4  "4a/a5/f0"
put_template 5  "c1/62/de"
put_template 6  "42/b3/c2"
put_template 7  "e6/e6/e6"
put_template 8  "68/70/80"
put_template 9  "ff/61/6e"
put_template 10 "a5/e0/75"
put_template 11 "f0/a4/5d"
put_template 12 "4d/c4/ff"
put_template 13 "de/73/ff"
put_template 14 "4c/d1/e0"
put_template 15 "ff/ff/ff"

color_foreground="ab/b2/bf"
color_background="3f/44/51"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "abb2bf"
  put_template_custom Ph "3f4451"
  put_template_custom Pi "abb2bf"
  put_template_custom Pj "abb2bf"
  put_template_custom Pk "3f4451"
  put_template_custom Pl "abb2bf"
  put_template_custom Pm "3f4451"
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
