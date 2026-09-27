#!/bin/sh
# Prince of Darkness

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
put_template 0  "2d/1b/4e"
put_template 1  "6a/2b/bd"
put_template 2  "c4/3d/ff"
put_template 3  "3e/c7/ff"
put_template 4  "7a/63/ff"
put_template 5  "ff/4e/db"
put_template 6  "5c/c8/ff"
put_template 7  "c5/a7/ff"
put_template 8  "67/61/75"
put_template 9  "a1/39/e6"
put_template 10 "ff/6b/d6"
put_template 11 "7a/e6/ff"
put_template 12 "9b/b4/ff"
put_template 13 "e3/84/ff"
put_template 14 "7a/e6/ff"
put_template 15 "f2/e6/ff"

color_foreground="dc/d3/ff"
color_background="0a/07/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dcd3ff"
  put_template_custom Ph "0a0714"
  put_template_custom Pi "8b5cf6"
  put_template_custom Pj "43206b"
  put_template_custom Pk "f2e6ff"
  put_template_custom Pl "b47dff"
  put_template_custom Pm "0a0714"
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
