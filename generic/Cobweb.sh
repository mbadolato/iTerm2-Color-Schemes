#!/bin/sh
# Cobweb

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
put_template 0  "ae/b5/ba"
put_template 1  "ed/8e/88"
put_template 2  "9b/c6/a3"
put_template 3  "de/c5/75"
put_template 4  "92/ba/d5"
put_template 5  "bb/a4/c9"
put_template 6  "88/c8/c8"
put_template 7  "ee/f1/f3"
put_template 8  "c3/c9/cd"
put_template 9  "f0/a7/a1"
put_template 10 "af/d3/b6"
put_template 11 "e8/d4/93"
put_template 12 "ab/cd/e0"
put_template 13 "ca/b8/d4"
put_template 14 "a4/d6/d6"
put_template 15 "ff/ff/ff"

color_foreground="ee/f1/f3"
color_background="20/27/2d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eef1f3"
  put_template_custom Ph "20272d"
  put_template_custom Pi "c7cdd2"
  put_template_custom Pj "3d454c"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "e7ebee"
  put_template_custom Pm "20272d"
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
