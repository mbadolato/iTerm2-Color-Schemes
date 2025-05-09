#!/bin/sh
# Aardvark Blue

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
put_template 0  "19/19/19"
put_template 1  "aa/34/2e"
put_template 2  "4b/8c/0f"
put_template 3  "db/ba/00"
put_template 4  "13/70/d3"
put_template 5  "c4/3a/c3"
put_template 6  "00/8e/b0"
put_template 7  "be/be/be"
put_template 8  "45/45/45"
put_template 9  "f0/5b/50"
put_template 10 "95/dc/55"
put_template 11 "ff/e7/63"
put_template 12 "60/a4/ec"
put_template 13 "e2/6b/e2"
put_template 14 "60/b6/cb"
put_template 15 "f7/f7/f7"

color_foreground="dd/dd/dd"
color_background="10/20/40"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dddddd"
  put_template_custom Ph "102040"
  put_template_custom Pi "f7f7f7"
  put_template_custom Pj "bfdbfe"
  put_template_custom Pk "000000"
  put_template_custom Pl "007acc"
  put_template_custom Pm "bfdbfe"
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
