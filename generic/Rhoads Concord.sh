#!/bin/sh
# Rhoads Concord

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
put_template 0  "2b/2b/2b"
put_template 1  "c8/1e/1e"
put_template 2  "2e/7d/32"
put_template 3  "d4/af/37"
put_template 4  "25/63/eb"
put_template 5  "a8/55/f7"
put_template 6  "06/b6/d4"
put_template 7  "bf/c1/c5"
put_template 8  "6b/6b/6b"
put_template 9  "ef/6b/6b"
put_template 10 "82/cf/75"
put_template 11 "cf/b9/64"
put_template 12 "7d/aa/f2"
put_template 13 "c5/9a/f2"
put_template 14 "76/ce/d8"
put_template 15 "ff/ff/ff"

color_foreground="1a/1a/1a"
color_background="fd/fc/f4"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1a1a1a"
  put_template_custom Ph "fdfcf4"
  put_template_custom Pi "d4af37"
  put_template_custom Pj "b8860b"
  put_template_custom Pk "e3c384"
  put_template_custom Pl "000000"
  put_template_custom Pm "4b4b4b"
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
