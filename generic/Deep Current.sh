#!/bin/sh
# Deep Current

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
put_template 0  "1f/2a/44"
put_template 1  "ff/4d/6d"
put_template 2  "22/c5/5e"
put_template 3  "f5/9e/0b"
put_template 4  "3b/82/f6"
put_template 5  "d9/46/ef"
put_template 6  "06/d6/a0"
put_template 7  "94/a3/b8"
put_template 8  "47/55/69"
put_template 9  "ff/7b/9c"
put_template 10 "86/ef/ac"
put_template 11 "fc/d3/4d"
put_template 12 "60/a5/fa"
put_template 13 "e8/79/f9"
put_template 14 "2d/d4/bf"
put_template 15 "f8/fa/fc"

color_foreground="e2/e8/f0"
color_background="08/12/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e2e8f0"
  put_template_custom Ph "08121f"
  put_template_custom Pi "1e293b"
  put_template_custom Pj "334155"
  put_template_custom Pk "e2e8f0"
  put_template_custom Pl "00c5ff"
  put_template_custom Pm "08121f"
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
