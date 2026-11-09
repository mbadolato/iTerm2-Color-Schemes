#!/bin/sh
# mistpine

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
put_template 0  "0f/27/2e"
put_template 1  "be/73/56"
put_template 2  "8a/9a/5b"
put_template 3  "c2/a5/5b"
put_template 4  "6f/8f/a8"
put_template 5  "9a/88/a8"
put_template 6  "5f/9a/96"
put_template 7  "a7/b0/bb"
put_template 8  "54/6b/76"
put_template 9  "d0/8a/6e"
put_template 10 "a9/b9/7a"
put_template 11 "dc/c2/7e"
put_template 12 "93/af/c4"
put_template 13 "b8/a8/c6"
put_template 14 "86/bc/b6"
put_template 15 "d0/d1/d6"

color_foreground="c4/c9/d0"
color_background="0b/1f/27"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c4c9d0"
  put_template_custom Ph "0b1f27"
  put_template_custom Pi "c4c9d0"
  put_template_custom Pj "26414a"
  put_template_custom Pk "d0d1d6"
  put_template_custom Pl "c4c9d0"
  put_template_custom Pm "0b1f27"
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
