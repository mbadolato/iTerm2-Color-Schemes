#!/bin/sh
# After Hours

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
put_template 0  "2a/1f/1a"
put_template 1  "ff/6b/6b"
put_template 2  "4a/de/80"
put_template 3  "f5/9e/0b"
put_template 4  "60/a5/fa"
put_template 5  "c0/84/fc"
put_template 6  "2d/d4/bf"
put_template 7  "cb/b8/9f"
put_template 8  "6b/5b/4f"
put_template 9  "ff/8b/8b"
put_template 10 "86/ef/ac"
put_template 11 "fb/bf/24"
put_template 12 "93/c5/fd"
put_template 13 "d8/b4/fe"
put_template 14 "5e/ea/d4"
put_template 15 "fd/fa/f6"

color_foreground="e6/e1/d9"
color_background="0f/0b/0a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e1d9"
  put_template_custom Ph "0f0b0a"
  put_template_custom Pi "2c2522"
  put_template_custom Pj "3d2f27"
  put_template_custom Pk "e6e1d9"
  put_template_custom Pl "d4af37"
  put_template_custom Pm "0f0b0a"
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
