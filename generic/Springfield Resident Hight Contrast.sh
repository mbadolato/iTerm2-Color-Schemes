#!/bin/sh
# Springfield Resident Hight Contrast

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
put_template 0  "17/1b/24"
put_template 1  "7a/10/26"
put_template 2  "13/4e/24"
put_template 3  "5d/3e/00"
put_template 4  "06/3d/82"
put_template 5  "67/14/5d"
put_template 6  "00/4a/5d"
put_template 7  "29/30/3b"
put_template 8  "34/3b/46"
put_template 9  "85/16/2c"
put_template 10 "16/4e/27"
put_template 11 "5c/3e/00"
put_template 12 "08/42/87"
put_template 13 "70/19/66"
put_template 14 "00/4a/5c"
put_template 15 "30/37/42"

color_foreground="06/2f/63"
color_background="ff/dd/32"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "062f63"
  put_template_custom Ph "ffdd32"
  put_template_custom Pi "073b78"
  put_template_custom Pj "0b4b94"
  put_template_custom Pk "fff3a3"
  put_template_custom Pl "0b4b94"
  put_template_custom Pm "fff3a3"
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
