#!/bin/sh
# Gruvbox Material Dark

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
put_template 1  "ea/69/62"
put_template 2  "a9/b6/65"
put_template 3  "d8/a6/57"
put_template 4  "7d/ae/a3"
put_template 5  "d3/86/9b"
put_template 6  "89/b4/82"
put_template 7  "d4/be/98"
put_template 8  "7c/6f/64"
put_template 9  "ea/69/62"
put_template 10 "a9/b6/65"
put_template 11 "d8/a6/57"
put_template 12 "7d/ae/a3"
put_template 13 "d3/86/9b"
put_template 14 "89/b4/82"
put_template 15 "dd/c7/a1"

color_foreground="d4/be/98"
color_background="28/28/28"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d4be98"
  put_template_custom Ph "282828"
  put_template_custom Pi "d4be98"
  put_template_custom Pj "d4be98"
  put_template_custom Pk "282828"
  put_template_custom Pl "d4be98"
  put_template_custom Pm "282828"
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
