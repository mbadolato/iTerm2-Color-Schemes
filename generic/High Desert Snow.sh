#!/bin/sh
# High Desert Snow

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
put_template 0  "1f/29/37"
put_template 1  "dc/26/26"
put_template 2  "16/a3/4a"
put_template 3  "ca/8a/04"
put_template 4  "25/63/eb"
put_template 5  "93/33/ea"
put_template 6  "08/91/b2"
put_template 7  "47/55/69"
put_template 8  "64/74/8b"
put_template 9  "ef/44/44"
put_template 10 "22/c5/5e"
put_template 11 "ea/b3/08"
put_template 12 "3b/82/f6"
put_template 13 "c0/84/fc"
put_template 14 "06/b6/d4"
put_template 15 "1f/29/37"

color_foreground="1f/29/37"
color_background="f9/fa/fb"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1f2937"
  put_template_custom Ph "f9fafb"
  put_template_custom Pi "e5e7eb"
  put_template_custom Pj "cbd5e1"
  put_template_custom Pk "1f2937"
  put_template_custom Pl "d97706"
  put_template_custom Pm "f3f4f6"
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
