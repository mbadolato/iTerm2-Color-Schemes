#!/bin/sh
# Ember

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
put_template 0  "40/26/1b"
put_template 1  "e4/57/3f"
put_template 2  "79/ad/58"
put_template 3  "d9/9a/33"
put_template 4  "61/96/e6"
put_template 5  "d0/77/b3"
put_template 6  "4a/c3/b1"
put_template 7  "d7/b9/95"
put_template 8  "6a/4a/38"
put_template 9  "ff/7b/5e"
put_template 10 "a8/c9/76"
put_template 11 "ff/c1/5a"
put_template 12 "8b/b8/f2"
put_template 13 "e5/9a/d6"
put_template 14 "66/d9/c4"
put_template 15 "ff/e8/c7"

color_foreground="f3/e3/d1"
color_background="1b/0f/0b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f3e3d1"
  put_template_custom Ph "1b0f0b"
  put_template_custom Pi "ceb892"
  put_template_custom Pj "4a2a1e"
  put_template_custom Pk "f3e3d1"
  put_template_custom Pl "d17a3c"
  put_template_custom Pm "1b0f0b"
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
