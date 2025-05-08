#!/bin/sh
# Duotone Dark

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
put_template 0  "1f/1d/27"
put_template 1  "d9/39/3e"
put_template 2  "2d/cd/73"
put_template 3  "d9/b7/6e"
put_template 4  "ff/c2/84"
put_template 5  "de/8d/40"
put_template 6  "24/88/ff"
put_template 7  "b7/a1/ff"
put_template 8  "35/31/47"
put_template 9  "d9/39/3e"
put_template 10 "2d/cd/73"
put_template 11 "d9/b7/6e"
put_template 12 "ff/c2/84"
put_template 13 "de/8d/40"
put_template 14 "24/88/ff"
put_template 15 "ea/e5/ff"

color_foreground="b7/a1/ff"
color_background="1f/1d/27"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b7a1ff"
  put_template_custom Ph "1f1d27"
  put_template_custom Pi "b7a2ff"
  put_template_custom Pj "353147"
  put_template_custom Pk "b7a2ff"
  put_template_custom Pl "ff9839"
  put_template_custom Pm "1f1d27"
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
