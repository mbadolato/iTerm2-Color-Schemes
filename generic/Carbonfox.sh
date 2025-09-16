#!/bin/sh
# Carbonfox

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
put_template 0  "28/28/28"
put_template 1  "ee/53/96"
put_template 2  "25/be/6a"
put_template 3  "08/bd/ba"
put_template 4  "78/a9/ff"
put_template 5  "be/95/ff"
put_template 6  "33/b1/ff"
put_template 7  "df/df/e0"
put_template 8  "48/48/48"
put_template 9  "f1/6d/a6"
put_template 10 "46/c8/80"
put_template 11 "2d/c7/c4"
put_template 12 "8c/b6/ff"
put_template 13 "c8/a5/ff"
put_template 14 "52/bd/ff"
put_template 15 "e4/e4/e5"

color_foreground="f2/f4/f8"
color_background="16/16/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2f4f8"
  put_template_custom Ph "161616"
  put_template_custom Pi "f2f4f8"
  put_template_custom Pj "2a2a2a"
  put_template_custom Pk "f2f4f8"
  put_template_custom Pl "f2f4f8"
  put_template_custom Pm "161616"
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
