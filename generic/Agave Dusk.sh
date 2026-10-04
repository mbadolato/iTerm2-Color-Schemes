#!/bin/sh
# Agave Dusk

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
put_template 0  "d0/d8/d0"
put_template 1  "ff/ad/91"
put_template 2  "a8/df/ae"
put_template 3  "f5/d5/78"
put_template 4  "af/d4/f1"
put_template 5  "ec/b0/d4"
put_template 6  "a6/e3/dc"
put_template 7  "ff/f0/d8"
put_template 8  "df/e5/dd"
put_template 9  "ff/c0/a7"
put_template 10 "bd/e8/c1"
put_template 11 "ff/e4/94"
put_template 12 "c7/e2/f5"
put_template 13 "f3/c6/df"
put_template 14 "c2/ee/e8"
put_template 15 "ff/fa/f0"

color_foreground="ff/f0/d8"
color_background="14/56/54"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d8"
  put_template_custom Ph "145654"
  put_template_custom Pi "a7dfbf"
  put_template_custom Pj "347371"
  put_template_custom Pk "fff8e9"
  put_template_custom Pl "f6bd59"
  put_template_custom Pm "145654"
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
