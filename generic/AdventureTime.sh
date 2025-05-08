#!/bin/sh
# AdventureTime

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
put_template 0  "05/04/04"
put_template 1  "bd/00/13"
put_template 2  "4a/b1/18"
put_template 3  "e7/74/1e"
put_template 4  "0f/4a/c6"
put_template 5  "66/59/93"
put_template 6  "70/a5/98"
put_template 7  "f8/dc/c0"
put_template 8  "4e/7c/bf"
put_template 9  "fc/5f/5a"
put_template 10 "9e/ff/6e"
put_template 11 "ef/c1/1a"
put_template 12 "19/97/c6"
put_template 13 "9b/59/53"
put_template 14 "c8/fa/f4"
put_template 15 "f6/f5/fb"

color_foreground="f8/dc/c0"
color_background="1f/1d/45"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8dcc0"
  put_template_custom Ph "1f1d45"
  put_template_custom Pi "bd0013"
  put_template_custom Pj "706b4e"
  put_template_custom Pk "f3d9c4"
  put_template_custom Pl "efbf38"
  put_template_custom Pm "08080a"
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
