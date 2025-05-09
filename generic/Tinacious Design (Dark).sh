#!/bin/sh
# Tinacious Design (Dark)

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
put_template 0  "1d/1d/26"
put_template 1  "ff/33/99"
put_template 2  "00/d3/64"
put_template 3  "ff/cc/66"
put_template 4  "00/cb/ff"
put_template 5  "cc/66/ff"
put_template 6  "00/ce/ca"
put_template 7  "cb/cb/f0"
put_template 8  "63/66/67"
put_template 9  "ff/2f/92"
put_template 10 "00/d3/64"
put_template 11 "ff/d4/79"
put_template 12 "00/cb/ff"
put_template 13 "d7/83/ff"
put_template 14 "00/d5/d4"
put_template 15 "d5/d6/f3"

color_foreground="cb/cb/f0"
color_background="1d/1d/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cbcbf0"
  put_template_custom Ph "1d1d26"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "ff3399"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "cbcbf0"
  put_template_custom Pm "ffffff"
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
