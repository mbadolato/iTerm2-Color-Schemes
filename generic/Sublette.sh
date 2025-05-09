#!/bin/sh
# Sublette

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
put_template 0  "25/30/45"
put_template 1  "ee/55/77"
put_template 2  "55/ee/77"
put_template 3  "ff/dd/88"
put_template 4  "55/88/ff"
put_template 5  "ff/77/cc"
put_template 6  "44/ee/ee"
put_template 7  "f5/f5/da"
put_template 8  "40/55/70"
put_template 9  "ee/66/55"
put_template 10 "99/ee/77"
put_template 11 "ff/ff/77"
put_template 12 "77/bb/ff"
put_template 13 "aa/88/ff"
put_template 14 "55/ff/bb"
put_template 15 "ff/ff/ee"

color_foreground="cc/ce/d0"
color_background="20/25/35"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ccced0"
  put_template_custom Ph "202535"
  put_template_custom Pi "ccced0"
  put_template_custom Pj "ccced0"
  put_template_custom Pk "202535"
  put_template_custom Pl "ccced0"
  put_template_custom Pm "202535"
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
