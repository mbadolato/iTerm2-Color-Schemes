#!/bin/sh
# Moving Signals

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
put_template 0  "a9/9b/9d"
put_template 1  "d5/6b/70"
put_template 2  "9c/b6/a2"
put_template 3  "d7/a9/6c"
put_template 4  "8b/aa/c0"
put_template 5  "b9/a0/b7"
put_template 6  "91/b5/b2"
put_template 7  "ef/e1/d3"
put_template 8  "c2/b2/b2"
put_template 9  "ee/83/82"
put_template 10 "af/cb/b2"
put_template 11 "ed/c3/85"
put_template 12 "a2/bf/d1"
put_template 13 "cd/b2/c8"
put_template 14 "a7/cc/c5"
put_template 15 "ff/f4/e8"

color_foreground="f6/e9/dc"
color_background="28/14/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f6e9dc"
  put_template_custom Ph "28141b"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "58303b"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "e6c077"
  put_template_custom Pm "28141b"
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
