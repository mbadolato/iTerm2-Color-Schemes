#!/bin/sh
# Lavandula

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
put_template 0  "23/00/46"
put_template 1  "7d/16/25"
put_template 2  "33/7e/6f"
put_template 3  "7f/6f/49"
put_template 4  "4f/4a/7f"
put_template 5  "5a/3f/7f"
put_template 6  "58/77/7f"
put_template 7  "73/6e/7d"
put_template 8  "37/2d/46"
put_template 9  "e0/51/67"
put_template 10 "52/e0/c4"
put_template 11 "e0/c3/86"
put_template 12 "8e/87/e0"
put_template 13 "a7/76/e0"
put_template 14 "9a/d4/e0"
put_template 15 "8c/91/fa"

color_foreground="73/6e/7d"
color_background="05/00/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "736e7d"
  put_template_custom Ph "050014"
  put_template_custom Pi "8c91fa"
  put_template_custom Pj "37323c"
  put_template_custom Pk "8c91fa"
  put_template_custom Pl "8c91fa"
  put_template_custom Pm "050014"
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
