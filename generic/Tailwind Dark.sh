#!/bin/sh
# Tailwind Dark

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
put_template 0  "40/40/40"
put_template 1  "f8/71/71"
put_template 2  "4a/de/80"
put_template 3  "fa/cc/15"
put_template 4  "38/bd/f8"
put_template 5  "e8/79/f9"
put_template 6  "2d/d4/bf"
put_template 7  "e5/e5/e5"
put_template 8  "a3/a3/a3"
put_template 9  "fc/a5/a5"
put_template 10 "86/ef/ac"
put_template 11 "fd/e0/47"
put_template 12 "7d/d3/fc"
put_template 13 "f0/ab/fc"
put_template 14 "5e/ea/d4"
put_template 15 "f5/f5/f5"

color_foreground="e5/e5/e5"
color_background="26/26/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e5e5e5"
  put_template_custom Ph "262626"
  put_template_custom Pi "e5e5e5"
  put_template_custom Pj "475569"
  put_template_custom Pk "e5e5e5"
  put_template_custom Pl "e5e5e5"
  put_template_custom Pm "262626"
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
