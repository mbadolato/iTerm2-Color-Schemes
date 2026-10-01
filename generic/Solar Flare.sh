#!/bin/sh
# Solar Flare

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
put_template 0  "29/29/29"
put_template 1  "8d/18/18"
put_template 2  "0f/5c/2b"
put_template 3  "68/50/00"
put_template 4  "15/47/9a"
put_template 5  "67/30/96"
put_template 6  "00/4b/5a"
put_template 7  "3a/3a/37"
put_template 8  "55/53/4d"
put_template 9  "98/20/20"
put_template 10 "0b/50/28"
put_template 11 "59/45/00"
put_template 12 "1a/50/a5"
put_template 13 "71/3a/9e"
put_template 14 "00/49/57"
put_template 15 "46/44/3e"

color_foreground="1a/1a/1a"
color_background="ff/f9/e6"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1a1a1a"
  put_template_custom Ph "fff9e6"
  put_template_custom Pi "9a3200"
  put_template_custom Pj "f5e1a8"
  put_template_custom Pk "1a1a1a"
  put_template_custom Pl "7d3e00"
  put_template_custom Pm "fff9e6"
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
