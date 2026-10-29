#!/bin/sh
# Rainbows and Unicorns Miami

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
put_template 0  "2a/21/48"
put_template 1  "ff/5c/8a"
put_template 2  "7c/f0/a8"
put_template 3  "ff/e2/7a"
put_template 4  "6f/b7/ff"
put_template 5  "ff/6f/d8"
put_template 6  "3f/e0/d0"
put_template 7  "d9/cb/e8"
put_template 8  "7a/6c/9c"
put_template 9  "ff/9e/64"
put_template 10 "a8/f7/c6"
put_template 11 "ff/ef/ae"
put_template 12 "a3/d2/ff"
put_template 13 "ff/a3/e8"
put_template 14 "8a/f0/e4"
put_template 15 "ff/ff/ff"

color_foreground="f9/ec/f5"
color_background="1b/14/33"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f9ecf5"
  put_template_custom Ph "1b1433"
  put_template_custom Pi "f9ecf5"
  put_template_custom Pj "ff6fd8"
  put_template_custom Pk "1b1433"
  put_template_custom Pl "ff6fd8"
  put_template_custom Pm "1b1433"
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
