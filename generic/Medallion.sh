#!/bin/sh
# Medallion

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
put_template 0  "00/00/00"
put_template 1  "b6/4c/00"
put_template 2  "7c/8b/16"
put_template 3  "d3/bd/26"
put_template 4  "61/6b/b0"
put_template 5  "8c/5a/90"
put_template 6  "91/6c/25"
put_template 7  "ca/c2/9a"
put_template 8  "5e/52/19"
put_template 9  "ff/91/49"
put_template 10 "b2/ca/3b"
put_template 11 "ff/e5/4a"
put_template 12 "ac/b8/ff"
put_template 13 "ff/a0/ff"
put_template 14 "ff/bc/51"
put_template 15 "fe/d6/98"

color_foreground="ca/c2/96"
color_background="1d/19/08"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cac296"
  put_template_custom Ph "1d1908"
  put_template_custom Pi "ffd890"
  put_template_custom Pj "626dac"
  put_template_custom Pk "cac29a"
  put_template_custom Pl "d3ba30"
  put_template_custom Pm "d2bc3d"
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
