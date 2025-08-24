#!/bin/sh
# Squirrelsong Dark

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
put_template 0  "37/29/20"
put_template 1  "ba/41/38"
put_template 2  "46/83/36"
put_template 3  "d4/b1/39"
put_template 4  "43/95/c6"
put_template 5  "85/5f/b8"
put_template 6  "2f/97/94"
put_template 7  "d3/b9/a2"
put_template 8  "70/4f/39"
put_template 9  "df/4d/43"
put_template 10 "65/9a/4c"
put_template 11 "e8/c2/3f"
put_template 12 "4c/a4/db"
put_template 13 "9d/70/da"
put_template 14 "60/ac/a9"
put_template 15 "f2/d4/bb"

color_foreground="b1/9b/89"
color_background="37/29/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b19b89"
  put_template_custom Ph "372920"
  put_template_custom Pi "f2d4bb"
  put_template_custom Pj "5b402e"
  put_template_custom Pk "b19b89"
  put_template_custom Pl "b19b89"
  put_template_custom Pm "372920"
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
