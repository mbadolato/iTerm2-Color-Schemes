#!/bin/sh
# Relaxed

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
put_template 0  "15/15/15"
put_template 1  "bc/56/53"
put_template 2  "90/9d/63"
put_template 3  "eb/c1/7a"
put_template 4  "6a/87/99"
put_template 5  "b0/66/98"
put_template 6  "c9/df/ff"
put_template 7  "d9/d9/d9"
put_template 8  "63/63/63"
put_template 9  "bc/56/53"
put_template 10 "a0/ac/77"
put_template 11 "eb/c1/7a"
put_template 12 "7e/aa/c7"
put_template 13 "b0/66/98"
put_template 14 "ac/bb/d0"
put_template 15 "f7/f7/f7"

color_foreground="d9/d9/d9"
color_background="35/3a/44"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d9d9d9"
  put_template_custom Ph "353a44"
  put_template_custom Pi "d9d9d9"
  put_template_custom Pj "6a7985"
  put_template_custom Pk "d9d9d9"
  put_template_custom Pl "d9d9d9"
  put_template_custom Pm "1b1b1b"
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
