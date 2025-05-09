#!/bin/sh
# Seti

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
put_template 0  "32/32/32"
put_template 1  "c2/28/32"
put_template 2  "8e/c4/3d"
put_template 3  "e0/c6/4f"
put_template 4  "43/a5/d5"
put_template 5  "8b/57/b5"
put_template 6  "8e/c4/3d"
put_template 7  "ee/ee/ee"
put_template 8  "32/32/32"
put_template 9  "c2/28/32"
put_template 10 "8e/c4/3d"
put_template 11 "e0/c6/4f"
put_template 12 "43/a5/d5"
put_template 13 "8b/57/b5"
put_template 14 "8e/c4/3d"
put_template 15 "ff/ff/ff"

color_foreground="ca/ce/cd"
color_background="11/12/13"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cacecd"
  put_template_custom Ph "111213"
  put_template_custom Pi "cacecd"
  put_template_custom Pj "303233"
  put_template_custom Pk "cacecd"
  put_template_custom Pl "e3bf21"
  put_template_custom Pm "e0be2e"
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
