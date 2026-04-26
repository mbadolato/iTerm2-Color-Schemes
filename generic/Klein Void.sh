#!/bin/sh
# Klein Void

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
put_template 0  "1a/1c/24"
put_template 1  "f0/98/90"
put_template 2  "a6/c0/80"
put_template 3  "e8/bc/75"
put_template 4  "00/2f/a7"
put_template 5  "d4/9b/b5"
put_template 6  "9f/c0/e5"
put_template 7  "cd/c7/b8"
put_template 8  "92/90/7a"
put_template 9  "d9/77/57"
put_template 10 "bc/c8/9c"
put_template 11 "f0/c8/80"
put_template 12 "a8/be/f0"
put_template 13 "c8/b4/d4"
put_template 14 "b0/d0/ed"
put_template 15 "f5/ef/de"

color_foreground="ed/e6/d3"
color_background="0b/0d/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ede6d3"
  put_template_custom Ph "0b0d14"
  put_template_custom Pi "ede6d3"
  put_template_custom Pj "002fa7"
  put_template_custom Pk "ede6d3"
  put_template_custom Pl "ede6d3"
  put_template_custom Pm "0b0d14"
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
