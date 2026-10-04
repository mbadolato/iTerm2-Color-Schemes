#!/bin/sh
# Saguaro

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
put_template 0  "ae/bd/b5"
put_template 1  "f0/8a/68"
put_template 2  "82/d4/9d"
put_template 3  "f2/c8/5f"
put_template 4  "72/d2/ce"
put_template 5  "e8/87/b0"
put_template 6  "7b/d9/d5"
put_template 7  "ff/f0/d5"
put_template 8  "c5/d0/ca"
put_template 9  "ff/a0/78"
put_template 10 "a2/df/b5"
put_template 11 "f8/d9/82"
put_template 12 "9b/e1/dc"
put_template 13 "f0/a6/c5"
put_template 14 "a3/e7/e2"
put_template 15 "ff/f9/ea"

color_foreground="ff/f0/d5"
color_background="00/1c/13"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d5"
  put_template_custom Ph "001c13"
  put_template_custom Pi "b9e46c"
  put_template_custom Pj "7b3d25"
  put_template_custom Pk "fff4dc"
  put_template_custom Pl "ffb52e"
  put_template_custom Pm "001c13"
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
