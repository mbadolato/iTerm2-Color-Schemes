#!/bin/sh
# Lumina Harbor Dark

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
put_template 0  "0e/23/3f"
put_template 1  "dd/6b/62"
put_template 2  "82/d9/b4"
put_template 3  "e8/d6/6b"
put_template 4  "87/c6/f2"
put_template 5  "e8/a9/e1"
put_template 6  "be/de/e4"
put_template 7  "af/bc/ca"
put_template 8  "76/88/9e"
put_template 9  "e8/8f/86"
put_template 10 "a1/f2/ce"
put_template 11 "fb/ea/87"
put_template 12 "b1/de/ff"
put_template 13 "ff/c5/f8"
put_template 14 "b8/f4/ff"
put_template 15 "cf/dc/eb"

color_foreground="cf/dc/eb"
color_background="0c/1e/37"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cfdceb"
  put_template_custom Ph "0c1e37"
  put_template_custom Pi "cfdceb"
  put_template_custom Pj "3e4a4b"
  put_template_custom Pk "cfdceb"
  put_template_custom Pl "cfdceb"
  put_template_custom Pm "0c1e37"
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
