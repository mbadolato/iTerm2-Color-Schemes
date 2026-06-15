#!/bin/sh
# Patina Moss

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
put_template 0  "33/36/2e"
put_template 1  "c0/78/78"
put_template 2  "5b/a8/86"
put_template 3  "d4/bf/6e"
put_template 4  "65/a8/b5"
put_template 5  "c0/8a/7d"
put_template 6  "63/a8/a6"
put_template 7  "db/d7/ca"
put_template 8  "58/5b/51"
put_template 9  "c0/78/78"
put_template 10 "5b/a8/86"
put_template 11 "d4/bf/6e"
put_template 12 "65/a8/b5"
put_template 13 "c0/8a/7d"
put_template 14 "63/a8/a6"
put_template 15 "db/d7/ca"

color_foreground="db/d7/ca"
color_background="20/23/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dbd7ca"
  put_template_custom Ph "20231f"
  put_template_custom Pi "dbd7ca"
  put_template_custom Pj "383b31"
  put_template_custom Pk "dbd7ca"
  put_template_custom Pl "dbd7ca"
  put_template_custom Pm "20231f"
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
