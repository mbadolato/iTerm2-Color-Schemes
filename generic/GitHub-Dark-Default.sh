#!/bin/sh
# GitHub-Dark-Default

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
put_template 0  "48/4f/58"
put_template 1  "ff/7b/72"
put_template 2  "3f/b9/50"
put_template 3  "d2/99/22"
put_template 4  "58/a6/ff"
put_template 5  "bc/8c/ff"
put_template 6  "39/c5/cf"
put_template 7  "b1/ba/c4"
put_template 8  "6e/76/81"
put_template 9  "ff/a1/98"
put_template 10 "56/d3/64"
put_template 11 "e3/b3/41"
put_template 12 "79/c0/ff"
put_template 13 "d2/a8/ff"
put_template 14 "56/d4/dd"
put_template 15 "ff/ff/ff"

color_foreground="e6/ed/f3"
color_background="0d/11/17"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6edf3"
  put_template_custom Ph "0d1117"
  put_template_custom Pi "e6edf3"
  put_template_custom Pj "e6edf3"
  put_template_custom Pk "0d1117"
  put_template_custom Pl "2f81f7"
  put_template_custom Pm "2f81f7"
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
