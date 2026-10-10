#!/bin/sh
# Scabos Sand

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
put_template 0  "ff/f0/d1"
put_template 1  "ff/db/c1"
put_template 2  "e1/f0/b7"
put_template 3  "ff/e2/9b"
put_template 4  "c6/e4/fc"
put_template 5  "ee/d2/f2"
put_template 6  "bc/e9/e6"
put_template 7  "ff/f4/dc"
put_template 8  "ff/f5/e5"
put_template 9  "ff/e6/cf"
put_template 10 "ef/f6/d1"
put_template 11 "ff/ea/ba"
put_template 12 "d8/ec/ff"
put_template 13 "f7/e0/f7"
put_template 14 "d3/f5/ef"
put_template 15 "ff/fb/ed"

color_foreground="ff/f4/dc"
color_background="79/56/3b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff4dc"
  put_template_custom Ph "79563b"
  put_template_custom Pi "ffeaba"
  put_template_custom Pj "8e684a"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "ffeaba"
  put_template_custom Pm "79563b"
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
