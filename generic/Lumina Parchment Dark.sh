#!/bin/sh
# Lumina Parchment Dark

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
put_template 0  "30/26/19"
put_template 1  "d4/71/69"
put_template 2  "92/d3/b9"
put_template 3  "e0/ba/6a"
put_template 4  "97/bd/f4"
put_template 5  "d4/a3/dc"
put_template 6  "85/cb/d3"
put_template 7  "ce/c4/b0"
put_template 8  "9f/91/80"
put_template 9  "e1/93/8b"
put_template 10 "aa/ee/d2"
put_template 11 "fa/d4/84"
put_template 12 "bb/d7/ff"
put_template 13 "ec/be/f3"
put_template 14 "9e/e5/ee"
put_template 15 "ef/e5/d0"

color_foreground="ef/e5/d0"
color_background="2a/21/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "efe5d0"
  put_template_custom Ph "2a2116"
  put_template_custom Pi "efe5d0"
  put_template_custom Pj "54452a"
  put_template_custom Pk "efe5d0"
  put_template_custom Pl "efe5d0"
  put_template_custom Pm "2a2116"
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
