#!/bin/sh
# Kwyjibo

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
put_template 0  "9e/ab/c8"
put_template 1  "ff/69/73"
put_template 2  "67/d3/91"
put_template 3  "ff/d5/29"
put_template 4  "70/af/ff"
put_template 5  "e8/93/e4"
put_template 6  "66/dc/e8"
put_template 7  "f5/f1/e8"
put_template 8  "b9/c3/d9"
put_template 9  "ff/8a/91"
put_template 10 "8a/e0/aa"
put_template 11 "ff/e2/69"
put_template 12 "98/c6/ff"
put_template 13 "ef/b3/ec"
put_template 14 "8c/e7/ef"
put_template 15 "ff/ff/ff"

color_foreground="f5/f1/e8"
color_background="07/17/3b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5f1e8"
  put_template_custom Ph "07173b"
  put_template_custom Pi "ffd529"
  put_template_custom Pj "236aa1"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "ffd529"
  put_template_custom Pm "07173b"
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
