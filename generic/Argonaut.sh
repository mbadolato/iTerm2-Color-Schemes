#!/bin/sh
# Argonaut

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
put_template 0  "23/23/23"
put_template 1  "ff/00/0f"
put_template 2  "8c/e1/0b"
put_template 3  "ff/b9/00"
put_template 4  "00/8d/f8"
put_template 5  "6d/43/a6"
put_template 6  "00/d8/eb"
put_template 7  "ff/ff/ff"
put_template 8  "44/44/44"
put_template 9  "ff/27/40"
put_template 10 "ab/e1/5b"
put_template 11 "ff/d2/42"
put_template 12 "00/92/ff"
put_template 13 "9a/5f/eb"
put_template 14 "67/ff/f0"
put_template 15 "ff/ff/ff"

color_foreground="ff/fa/f4"
color_background="0e/10/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fffaf4"
  put_template_custom Ph "0e1019"
  put_template_custom Pi "9e9c9a"
  put_template_custom Pj "002a3b"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "ff0018"
  put_template_custom Pm "ff0018"
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
