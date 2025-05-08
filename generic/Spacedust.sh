#!/bin/sh
# Spacedust

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
put_template 0  "6e/53/46"
put_template 1  "e3/5b/00"
put_template 2  "5c/ab/96"
put_template 3  "e3/cd/7b"
put_template 4  "0f/54/8b"
put_template 5  "e3/5b/00"
put_template 6  "06/af/c7"
put_template 7  "f0/f1/ce"
put_template 8  "68/4c/31"
put_template 9  "ff/8a/3a"
put_template 10 "ae/ca/b8"
put_template 11 "ff/c8/78"
put_template 12 "67/a0/ce"
put_template 13 "ff/8a/3a"
put_template 14 "83/a7/b4"
put_template 15 "fe/ff/f1"

color_foreground="ec/f0/c1"
color_background="0a/1e/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ecf0c1"
  put_template_custom Ph "0a1e24"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "0a385c"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "708284"
  put_template_custom Pm "002831"
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
