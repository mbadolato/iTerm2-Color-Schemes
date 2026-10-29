#!/bin/sh
# Rainbows and Unicorns Workbench

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
put_template 0  "00/00/22"
put_template 1  "ff/a7/9b"
put_template 2  "a6/ee/8e"
put_template 3  "ff/d9/78"
put_template 4  "9a/d2/ff"
put_template 5  "f0/b0/f2"
put_template 6  "8c/ec/e2"
put_template 7  "dc/e6/f2"
put_template 8  "7f/a3/cf"
put_template 9  "ff/b0/66"
put_template 10 "c8/f7/b6"
put_template 11 "ff/e9/a6"
put_template 12 "c2/e4/ff"
put_template 13 "f7/cf/f8"
put_template 14 "bc/f5/ee"
put_template 15 "ff/ff/ff"

color_foreground="ff/ff/ff"
color_background="00/40/8f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffffff"
  put_template_custom Ph "00408f"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "ffffff"
  put_template_custom Pk "00408f"
  put_template_custom Pl "ff8800"
  put_template_custom Pm "00204a"
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
