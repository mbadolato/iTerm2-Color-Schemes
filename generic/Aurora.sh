#!/bin/sh
# Aurora

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
put_template 0  "23/26/2e"
put_template 1  "f0/26/6f"
put_template 2  "8f/d4/6d"
put_template 3  "ff/e6/6d"
put_template 4  "03/21/d7"
put_template 5  "ee/5d/43"
put_template 6  "03/d6/b8"
put_template 7  "c7/4d/ed"
put_template 8  "29/2e/38"
put_template 9  "f9/26/72"
put_template 10 "8f/d4/6d"
put_template 11 "ff/e6/6d"
put_template 12 "03/d6/b8"
put_template 13 "ee/5d/43"
put_template 14 "03/d6/b8"
put_template 15 "c7/4d/ed"

color_foreground="ff/ca/28"
color_background="23/26/2e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffca28"
  put_template_custom Ph "23262e"
  put_template_custom Pi "fbfbff"
  put_template_custom Pj "292e38"
  put_template_custom Pk "00e8c6"
  put_template_custom Pl "ee5d43"
  put_template_custom Pm "ffd29c"
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
