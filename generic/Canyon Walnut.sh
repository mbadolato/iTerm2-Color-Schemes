#!/bin/sh
# Canyon Walnut

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
put_template 0  "c7/ad/93"
put_template 1  "ed/93/71"
put_template 2  "b3/c9/8a"
put_template 3  "f2/bb/5f"
put_template 4  "8f/bd/e7"
put_template 5  "c9/a0/d9"
put_template 6  "8d/d1/ce"
put_template 7  "f8/e4/c6"
put_template 8  "dc/c3/a8"
put_template 9  "ff/b0/8c"
put_template 10 "c8/dd/9f"
put_template 11 "ff/d2/7e"
put_template 12 "ab/d1/f5"
put_template 13 "dd/b7/eb"
put_template 14 "a9/e2/db"
put_template 15 "ff/f5/dc"

color_foreground="f8/e4/c6"
color_background="33/20/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8e4c6"
  put_template_custom Ph "332014"
  put_template_custom Pi "ffd27e"
  put_template_custom Pj "8e684a"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "ffd27e"
  put_template_custom Pm "332014"
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
