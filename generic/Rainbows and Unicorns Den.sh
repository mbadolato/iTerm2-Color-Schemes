#!/bin/sh
# Rainbows and Unicorns Den

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
put_template 0  "2e/21/15"
put_template 1  "d9/58/3b"
put_template 2  "9d/b8/5c"
put_template 3  "e0/a0/30"
put_template 4  "6f/9f/b8"
put_template 5  "b8/7a/9a"
put_template 6  "7f/b0/a0"
put_template 7  "cd/bb/98"
put_template 8  "7d/6a/50"
put_template 9  "d9/80/36"
put_template 10 "bb/d4/7e"
put_template 11 "f0/be/5c"
put_template 12 "95/bd/d2"
put_template 13 "d2/9c/b8"
put_template 14 "a2/cd/bf"
put_template 15 "ff/f3/da"

color_foreground="eb/d9/b8"
color_background="1e/15/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ebd9b8"
  put_template_custom Ph "1e150d"
  put_template_custom Pi "ebd9b8"
  put_template_custom Pj "e0a030"
  put_template_custom Pk "1e150d"
  put_template_custom Pl "e0a030"
  put_template_custom Pm "1e150d"
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
