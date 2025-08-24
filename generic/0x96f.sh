#!/bin/sh
# 0x96f

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
put_template 0  "26/24/27"
put_template 1  "ff/66/6d"
put_template 2  "b3/e0/3a"
put_template 3  "ff/c7/39"
put_template 4  "00/cd/e8"
put_template 5  "a3/92/e8"
put_template 6  "9d/ea/f6"
put_template 7  "fc/fc/fa"
put_template 8  "54/54/52"
put_template 9  "ff/7e/83"
put_template 10 "be/e5/5e"
put_template 11 "ff/d0/5e"
put_template 12 "1b/d5/eb"
put_template 13 "b0/a3/eb"
put_template 14 "ac/ed/f8"
put_template 15 "fc/fc/fa"

color_foreground="fc/fc/fa"
color_background="26/24/27"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fcfcfa"
  put_template_custom Ph "262427"
  put_template_custom Pi "fcfcfa"
  put_template_custom Pj "fcfcfa"
  put_template_custom Pk "262427"
  put_template_custom Pl "fcfcfa"
  put_template_custom Pm "000000"
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
