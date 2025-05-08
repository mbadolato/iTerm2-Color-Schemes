#!/bin/sh
# One Double Dark

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
put_template 0  "3e/44/51"
put_template 1  "e0/6c/75"
put_template 2  "98/c3/79"
put_template 3  "e5/c0/7b"
put_template 4  "61/af/ef"
put_template 5  "c6/78/dd"
put_template 6  "56/b6/c2"
put_template 7  "dc/df/e4"
put_template 8  "54/5d/6d"
put_template 9  "fd/80/7f"
put_template 10 "96/d5/8b"
put_template 11 "ed/c2/73"
put_template 12 "84/c8/ff"
put_template 13 "ee/82/ee"
put_template 14 "3a/e1/f7"
put_template 15 "f7/f9/fc"

color_foreground="dc/df/e4"
color_background="29/2c/33"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dcdfe4"
  put_template_custom Ph "292c33"
  put_template_custom Pi "f7f9fc"
  put_template_custom Pj "595b6e"
  put_template_custom Pk "cfd6f1"
  put_template_custom Pl "f1e1dd"
  put_template_custom Pm "cfd6f1"
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
