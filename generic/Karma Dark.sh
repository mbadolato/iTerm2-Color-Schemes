#!/bin/sh
# Karma Dark

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
put_template 0  "0a/0e/14"
put_template 1  "fc/61/8d"
put_template 2  "7b/d8/8f"
put_template 3  "fc/e5/66"
put_template 4  "5a/d4/e6"
put_template 5  "af/98/e6"
put_template 6  "5a/d4/e6"
put_template 7  "ba/b6/c0"
put_template 8  "69/67/6c"
put_template 9  "ff/7b/a0"
put_template 10 "9c/e3/ab"
put_template 11 "fc/e5/66"
put_template 12 "7f/e0/ee"
put_template 13 "c3/b0/f0"
put_template 14 "7f/e0/ee"
put_template 15 "f7/f1/ff"

color_foreground="f7/f1/ff"
color_background="0a/0e/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7f1ff"
  put_template_custom Ph "0a0e14"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "3a384a"
  put_template_custom Pk "f7f1ff"
  put_template_custom Pl "fce566"
  put_template_custom Pm "0a0e14"
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
