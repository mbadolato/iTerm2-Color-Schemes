#!/bin/sh
# sonokai

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
put_template 0  "18/18/19"
put_template 1  "fc/5d/7c"
put_template 2  "9e/d0/72"
put_template 3  "e7/c6/64"
put_template 4  "76/cc/e0"
put_template 5  "b3/9d/f3"
put_template 6  "f3/96/60"
put_template 7  "e2/e2/e3"
put_template 8  "7f/84/90"
put_template 9  "fc/5d/7c"
put_template 10 "9e/d0/72"
put_template 11 "e7/c6/64"
put_template 12 "76/cc/e0"
put_template 13 "b3/9d/f3"
put_template 14 "f3/96/60"
put_template 15 "e2/e2/e3"

color_foreground="e2/e2/e3"
color_background="2c/2e/34"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e2e2e3"
  put_template_custom Ph "2c2e34"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "414550"
  put_template_custom Pk "e2e2e3"
  put_template_custom Pl "e2e2e3"
  put_template_custom Pm "2c2e34"
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
