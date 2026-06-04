#!/bin/sh
# Sequoia Moonlight Dark

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
put_template 0  "13/13/17"
put_template 1  "f5/8e/e0"
put_template 2  "8e/b6/f5"
put_template 3  "98/98/a6"
put_template 4  "c5/8f/ff"
put_template 5  "fd/fd/fe"
put_template 6  "ff/bb/88"
put_template 7  "86/86/90"
put_template 8  "57/58/61"
put_template 9  "f5/8e/e0"
put_template 10 "8e/b6/f5"
put_template 11 "98/98/a6"
put_template 12 "c5/8f/ff"
put_template 13 "fd/fd/fe"
put_template 14 "ff/bb/88"
put_template 15 "86/86/90"

color_foreground="86/86/90"
color_background="0f/10/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "868690"
  put_template_custom Ph "0f1014"
  put_template_custom Pi "868690"
  put_template_custom Pj "817c9c"
  put_template_custom Pk "acacb6"
  put_template_custom Pl "43444d"
  put_template_custom Pm "868690"
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
