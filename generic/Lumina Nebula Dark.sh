#!/bin/sh
# Lumina Nebula Dark

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
put_template 0  "1a/1c/2c"
put_template 1  "d5/70/68"
put_template 2  "8f/dc/ba"
put_template 3  "f3/c0/85"
put_template 4  "c6/d6/e8"
put_template 5  "e5/ae/df"
put_template 6  "88/d2/da"
put_template 7  "bd/c1/cb"
put_template 8  "83/8b/a5"
put_template 9  "e2/92/8a"
put_template 10 "b0/f5/d5"
put_template 11 "ff/df/ba"
put_template 12 "d8/ea/ff"
put_template 13 "ff/c8/f9"
put_template 14 "a1/ec/f5"
put_template 15 "dd/e1/ec"

color_foreground="dd/e1/ec"
color_background="16/18/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dde1ec"
  put_template_custom Ph "161826"
  put_template_custom Pi "dde1ec"
  put_template_custom Pj "393856"
  put_template_custom Pk "dde1ec"
  put_template_custom Pl "dde1ec"
  put_template_custom Pm "161826"
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
