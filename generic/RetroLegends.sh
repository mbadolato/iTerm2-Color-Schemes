#!/bin/sh
# RetroLegends

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
put_template 0  "26/26/26"
put_template 1  "de/54/54"
put_template 2  "45/eb/45"
put_template 3  "f7/bf/2b"
put_template 4  "40/66/f2"
put_template 5  "bf/4c/f2"
put_template 6  "40/d9/e6"
put_template 7  "bf/e6/bf"
put_template 8  "4c/59/4c"
put_template 9  "ff/66/66"
put_template 10 "59/ff/59"
put_template 11 "ff/d9/33"
put_template 12 "4c/80/ff"
put_template 13 "e6/66/ff"
put_template 14 "59/e6/ff"
put_template 15 "f2/ff/f2"

color_foreground="45/eb/45"
color_background="0d/0d/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "45eb45"
  put_template_custom Ph "0d0d0d"
  put_template_custom Pi "59ff59"
  put_template_custom Pj "336633"
  put_template_custom Pk "f2fff2"
  put_template_custom Pl "45eb45"
  put_template_custom Pm "0d0d0d"
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
