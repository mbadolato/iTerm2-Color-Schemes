#!/bin/sh
# Oxide

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
put_template 0  "26/26/26"
put_template 1  "ed/75/6e"
put_template 2  "5b/b6/61"
put_template 3  "c3/99/00"
put_template 4  "3b/a6/f5"
put_template 5  "96/8f/f7"
put_template 6  "00/ba/aa"
put_template 7  "ce/ce/ce"
put_template 8  "8f/8f/8f"
put_template 9  "ff/98/90"
put_template 10 "7b/d7/7f"
put_template 11 "e3/b8/31"
put_template 12 "6f/c6/ff"
put_template 13 "b5/b2/ff"
put_template 14 "00/dc/ca"
put_template 15 "de/de/de"

color_foreground="ce/ce/ce"
color_background="16/16/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cecece"
  put_template_custom Ph "161616"
  put_template_custom Pi "cecece"
  put_template_custom Pj "262626"
  put_template_custom Pk "cecece"
  put_template_custom Pl "cecece"
  put_template_custom Pm "161616"
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
