#!/bin/sh
# Nephrite Jade

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
put_template 0  "2e/46/39"
put_template 1  "ff/aa/a7"
put_template 2  "4d/bf/74"
put_template 3  "e0/c2/62"
put_template 4  "96/c9/fe"
put_template 5  "d5/b2/ff"
put_template 6  "4c/db/e3"
put_template 7  "bd/cc/c3"
put_template 8  "7f/91/87"
put_template 9  "ff/aa/a7"
put_template 10 "65/dd/bb"
put_template 11 "e0/c2/62"
put_template 12 "96/c9/fe"
put_template 13 "fe/a4/cc"
put_template 14 "4c/db/e3"
put_template 15 "e7/f2/eb"

color_foreground="e7/f2/eb"
color_background="13/2e/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e7f2eb"
  put_template_custom Ph "132e20"
  put_template_custom Pi "e7f2eb"
  put_template_custom Pj "3c5346"
  put_template_custom Pk "e7f2eb"
  put_template_custom Pl "4dbf74"
  put_template_custom Pm "132e20"
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
