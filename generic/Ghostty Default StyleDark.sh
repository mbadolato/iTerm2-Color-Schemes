#!/bin/sh
# Ghostty Default StyleDark

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
put_template 0  "1d/1f/21"
put_template 1  "bf/6b/69"
put_template 2  "b7/bd/73"
put_template 3  "e9/c8/80"
put_template 4  "88/a1/bb"
put_template 5  "ad/95/b8"
put_template 6  "95/bd/b7"
put_template 7  "c5/c8/c6"
put_template 8  "66/66/66"
put_template 9  "c5/57/57"
put_template 10 "bc/c9/5f"
put_template 11 "e1/c6/5e"
put_template 12 "83/a5/d6"
put_template 13 "bc/99/d4"
put_template 14 "83/be/b1"
put_template 15 "ea/ea/ea"

color_foreground="ff/ff/ff"
color_background="29/2c/33"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffffff"
  put_template_custom Ph "292c33"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "ffffff"
  put_template_custom Pk "292c33"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "363a43"
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
