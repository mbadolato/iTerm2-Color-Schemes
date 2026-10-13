#!/bin/sh
# Jump Start

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
put_template 0  "a8/b2/b8"
put_template 1  "ee/79/8a"
put_template 2  "83/c7/a3"
put_template 3  "f1/c8/6b"
put_template 4  "81/b9/f2"
put_template 5  "d4/9e/e5"
put_template 6  "79/d0/e0"
put_template 7  "e8/f1/fa"
put_template 8  "b9/c1/c6"
put_template 9  "f0/89/98"
put_template 10 "92/ce/ae"
put_template 11 "f3/cf/7d"
put_template 12 "90/c1/f4"
put_template 13 "d9/aa/e8"
put_template 14 "89/d6/e4"
put_template 15 "ed/f4/fb"

color_foreground="e8/f1/fa"
color_background="07/1e/35"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8f1fa"
  put_template_custom Ph "071e35"
  put_template_custom Pi "edf4fb"
  put_template_custom Pj "383b51"
  put_template_custom Pk "e8f1fa"
  put_template_custom Pl "f3cf7d"
  put_template_custom Pm "071e35"
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
