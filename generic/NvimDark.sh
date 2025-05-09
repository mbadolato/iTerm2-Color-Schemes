#!/bin/sh
# NvimDark

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
put_template 0  "07/08/0d"
put_template 1  "ff/c0/b9"
put_template 2  "b3/f6/c0"
put_template 3  "fc/e0/94"
put_template 4  "a6/db/ff"
put_template 5  "ff/ca/ff"
put_template 6  "8c/f8/f7"
put_template 7  "ee/f1/f8"
put_template 8  "4f/52/58"
put_template 9  "ff/c0/b9"
put_template 10 "b3/f6/c0"
put_template 11 "fc/e0/94"
put_template 12 "a6/db/ff"
put_template 13 "ff/ca/ff"
put_template 14 "8c/f8/f7"
put_template 15 "ee/f1/f8"

color_foreground="e0/e2/ea"
color_background="14/16/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0e2ea"
  put_template_custom Ph "14161b"
  put_template_custom Pi "e0e2ea"
  put_template_custom Pj "4f5258"
  put_template_custom Pk "e0e2ea"
  put_template_custom Pl "9b9ea4"
  put_template_custom Pm "e0e2ea"
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
