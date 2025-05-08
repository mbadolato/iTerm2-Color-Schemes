#!/bin/sh
# farmhouse-light

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
put_template 0  "1d/20/27"
put_template 1  "8d/00/03"
put_template 2  "3a/7d/00"
put_template 3  "a9/56/00"
put_template 4  "09/2c/cd"
put_template 5  "82/00/46"
put_template 6  "22/92/56"
put_template 7  "e8/e4/e1"
put_template 8  "39/40/47"
put_template 9  "eb/00/09"
put_template 10 "7a/c1/00"
put_template 11 "ea/9a/00"
put_template 12 "00/6e/fe"
put_template 13 "bf/3b/7f"
put_template 14 "19/e0/62"
put_template 15 "f4/ee/f0"

color_foreground="1d/20/27"
color_background="e8/e4/e1"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1d2027"
  put_template_custom Ph "e8e4e1"
  put_template_custom Pi "eb0009"
  put_template_custom Pj "b3b1aa"
  put_template_custom Pk "4d5658"
  put_template_custom Pl "006efe"
  put_template_custom Pm "1d2027"
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
