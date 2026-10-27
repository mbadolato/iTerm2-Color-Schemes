#!/bin/sh
# Sonoran Afterglow

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
put_template 0  "30/28/3a"
put_template 1  "d6/6d/73"
put_template 2  "83/ad/89"
put_template 3  "d9/ae/69"
put_template 4  "81/9c/d3"
put_template 5  "b7/8e/c5"
put_template 6  "67/b8/b0"
put_template 7  "d8/cc/c7"
put_template 8  "67/58/6d"
put_template 9  "f4/7c/65"
put_template 10 "a5/d0/a3"
put_template 11 "f2/cb/82"
put_template 12 "a5/ba/f1"
put_template 13 "d7/ac/e0"
put_template 14 "86/e0/d3"
put_template 15 "ff/f1/e3"

color_foreground="ed/e1/d9"
color_background="20/1a/2b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ede1d9"
  put_template_custom Ph "201a2b"
  put_template_custom Pi "ede1d9"
  put_template_custom Pj "49364c"
  put_template_custom Pk "6c6677"
  put_template_custom Pl "e9b872"
  put_template_custom Pm "201a2b"
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
