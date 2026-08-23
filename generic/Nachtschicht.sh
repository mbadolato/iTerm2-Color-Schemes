#!/bin/sh
# Nachtschicht

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
put_template 0  "0e/10/12"
put_template 1  "e5/48/4d"
put_template 2  "33/d1/7a"
put_template 3  "e3/b3/41"
put_template 4  "4d/7c/fe"
put_template 5  "c8/6a/d8"
put_template 6  "3f/c8/b0"
put_template 7  "c9/cf/d6"
put_template 8  "9d/a4/af"
put_template 9  "ef/8f/92"
put_template 10 "76/e0/a5"
put_template 11 "ed/cf/88"
put_template 12 "9e/b8/fe"
put_template 13 "e0/ab/e9"
put_template 14 "7e/da/ca"
put_template 15 "e8/ea/ed"

color_foreground="e8/ea/ed"
color_background="17/19/1d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8eaed"
  put_template_custom Ph "17191d"
  put_template_custom Pi "e8eaed"
  put_template_custom Pj "36393c"
  put_template_custom Pk "e8eaed"
  put_template_custom Pl "e3b341"
  put_template_custom Pm "17191d"
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
