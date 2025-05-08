#!/bin/sh
# 3024 Day

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
put_template 0  "09/03/00"
put_template 1  "db/2d/20"
put_template 2  "01/a2/52"
put_template 3  "fd/ed/02"
put_template 4  "01/a0/e4"
put_template 5  "a1/6a/94"
put_template 6  "b5/e4/f4"
put_template 7  "a5/a2/a2"
put_template 8  "5c/58/55"
put_template 9  "e8/bb/d0"
put_template 10 "3a/34/32"
put_template 11 "4a/45/43"
put_template 12 "80/7d/7c"
put_template 13 "d6/d5/d4"
put_template 14 "cd/ab/53"
put_template 15 "f7/f7/f7"

color_foreground="4a/45/43"
color_background="f7/f7/f7"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "4a4543"
  put_template_custom Ph "f7f7f7"
  put_template_custom Pi "4a4543"
  put_template_custom Pj "a5a2a2"
  put_template_custom Pk "4a4543"
  put_template_custom Pl "4a4543"
  put_template_custom Pm "f7f7f7"
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
