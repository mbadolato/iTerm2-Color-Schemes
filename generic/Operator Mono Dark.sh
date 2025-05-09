#!/bin/sh
# Operator Mono Dark

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
put_template 0  "5a/5a/5a"
put_template 1  "ca/37/2d"
put_template 2  "4d/7b/3a"
put_template 3  "d4/d6/97"
put_template 4  "43/87/cf"
put_template 5  "b8/6c/b4"
put_template 6  "72/d5/c6"
put_template 7  "ce/d4/cd"
put_template 8  "9a/9b/99"
put_template 9  "c3/7d/62"
put_template 10 "83/d0/a2"
put_template 11 "fd/fd/c5"
put_template 12 "89/d3/f6"
put_template 13 "ff/2c/7a"
put_template 14 "82/ea/da"
put_template 15 "fd/fd/f6"

color_foreground="c3/ca/c2"
color_background="19/19/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c3cac2"
  put_template_custom Ph "191919"
  put_template_custom Pi "fefdbf"
  put_template_custom Pj "19273b"
  put_template_custom Pk "dde5dc"
  put_template_custom Pl "fcdc08"
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
