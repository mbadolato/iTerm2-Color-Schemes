#!/bin/sh
# HaX0R_BLUE

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
put_template 0  "01/09/21"
put_template 1  "10/b6/ff"
put_template 2  "10/b6/ff"
put_template 3  "10/b6/ff"
put_template 4  "10/b6/ff"
put_template 5  "10/b6/ff"
put_template 6  "10/b6/ff"
put_template 7  "fa/fa/fa"
put_template 8  "08/01/17"
put_template 9  "00/b3/f7"
put_template 10 "00/b3/f7"
put_template 11 "00/b3/f7"
put_template 12 "00/b3/f7"
put_template 13 "00/b3/f7"
put_template 14 "00/b3/f7"
put_template 15 "fe/fe/fe"

color_foreground="11/b7/ff"
color_background="01/05/15"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "11b7ff"
  put_template_custom Ph "010515"
  put_template_custom Pi "00b4f8"
  put_template_custom Pj "c1e4ff"
  put_template_custom Pk "f6f6f6"
  put_template_custom Pl "10b6ff"
  put_template_custom Pm "ffffff"
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
