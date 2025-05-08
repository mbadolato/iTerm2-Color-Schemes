#!/bin/sh
# Belafonte Day

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
put_template 0  "20/11/1b"
put_template 1  "be/10/0e"
put_template 2  "85/81/62"
put_template 3  "ea/a5/49"
put_template 4  "42/6a/79"
put_template 5  "97/52/2c"
put_template 6  "98/9a/9c"
put_template 7  "96/8c/83"
put_template 8  "5e/52/52"
put_template 9  "be/10/0e"
put_template 10 "85/81/62"
put_template 11 "ea/a5/49"
put_template 12 "42/6a/79"
put_template 13 "97/52/2c"
put_template 14 "98/9a/9c"
put_template 15 "d5/cc/ba"

color_foreground="45/37/3c"
color_background="d5/cc/ba"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "45373c"
  put_template_custom Ph "d5ccba"
  put_template_custom Pi "45373c"
  put_template_custom Pj "968c83"
  put_template_custom Pk "45373c"
  put_template_custom Pl "45373c"
  put_template_custom Pm "d5ccba"
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
