#!/bin/sh
# Everforest Dark - Hard

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
put_template 0  "7a/84/78"
put_template 1  "e6/7e/80"
put_template 2  "a7/c0/80"
put_template 3  "db/bc/7f"
put_template 4  "7f/bb/b3"
put_template 5  "d6/99/b6"
put_template 6  "83/c0/92"
put_template 7  "f2/ef/df"
put_template 8  "a6/b0/a0"
put_template 9  "f8/55/52"
put_template 10 "8d/a1/01"
put_template 11 "df/a0/00"
put_template 12 "3a/94/c5"
put_template 13 "df/69/ba"
put_template 14 "35/a7/7c"
put_template 15 "ff/fb/ef"

color_foreground="d3/c6/aa"
color_background="1e/23/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d3c6aa"
  put_template_custom Ph "1e2326"
  put_template_custom Pi "dbbc7f"
  put_template_custom Pj "4c3743"
  put_template_custom Pk "d3c6aa"
  put_template_custom Pl "e69875"
  put_template_custom Pm "4c3743"
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
