#!/bin/sh
# Vacuum Tube

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
put_template 0  "bd/b5/aa"
put_template 1  "ff/82/6d"
put_template 2  "79/d0/9b"
put_template 3  "f5/cb/67"
put_template 4  "8f/b4/ee"
put_template 5  "d9/a1/e8"
put_template 6  "83/d3/dc"
put_template 7  "f7/ef/e3"
put_template 8  "ce/c7/bd"
put_template 9  "ff/9e/8e"
put_template 10 "99/dd/b4"
put_template 11 "f9/dc/89"
put_template 12 "ad/c8/f4"
put_template 13 "e7/bb/ed"
put_template 14 "a4/e2/e7"
put_template 15 "ff/fa/f2"

color_foreground="f7/ef/e3"
color_background="0c/09/07"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7efe3"
  put_template_custom Ph "0c0907"
  put_template_custom Pi "ffad63"
  put_template_custom Pj "35251a"
  put_template_custom Pk "fff4e8"
  put_template_custom Pl "ffc078"
  put_template_custom Pm "0c0907"
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
