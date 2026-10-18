#!/bin/sh
# Callie

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
put_template 0  "33/24/3a"
put_template 1  "ea/ab/a8"
put_template 2  "9d/cc/a3"
put_template 3  "d6/ba/86"
put_template 4  "a4/be/ef"
put_template 5  "e5/aa/c1"
put_template 6  "82/cd/cd"
put_template 7  "c9/b7/c6"
put_template 8  "9a/87/97"
put_template 9  "fa/c5/c2"
put_template 10 "ba/e0/be"
put_template 11 "e8/d1/a8"
put_template 12 "bf/d5/fd"
put_template 13 "f5/c5/d7"
put_template 14 "a6/e1/e1"
put_template 15 "f6/ee/f5"

color_foreground="e0/d3/df"
color_background="1c/12/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0d3df"
  put_template_custom Ph "1c1220"
  put_template_custom Pi "e0d3df"
  put_template_custom Pj "3d2c42"
  put_template_custom Pk "e0d3df"
  put_template_custom Pl "f08fb8"
  put_template_custom Pm "2e0f20"
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
