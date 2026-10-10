#!/bin/sh
# Count Terminal

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
put_template 0  "bc/a9/ad"
put_template 1  "ef/7e/88"
put_template 2  "99/c5/8e"
put_template 3  "e1/c4/67"
put_template 4  "88/b5/d7"
put_template 5  "c5/8b/b9"
put_template 6  "7b/c6/bf"
put_template 7  "f7/e6/dc"
put_template 8  "c4/b3/b7"
put_template 9  "f1/8d/96"
put_template 10 "a5/cc/9c"
put_template 11 "e5/cb/79"
put_template 12 "96/be/dc"
put_template 13 "cc/99/c1"
put_template 14 "8b/cd/c7"
put_template 15 "f8/e9/e0"

color_foreground="f7/e6/dc"
color_background="48/08/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7e6dc"
  put_template_custom Ph "480814"
  put_template_custom Pi "e5cb79"
  put_template_custom Pj "c4b3b7"
  put_template_custom Pk "fff6ed"
  put_template_custom Pl "f18d96"
  put_template_custom Pm "480814"
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
