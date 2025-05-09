#!/bin/sh
# Elegant

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
put_template 0  "0c/12/21"
put_template 1  "ea/33/5b"
put_template 2  "95/ca/9a"
put_template 3  "f7/cd/94"
put_template 4  "93/aa/dd"
put_template 5  "bf/94/e5"
put_template 6  "8c/ca/ec"
put_template 7  "ff/ff/ff"
put_template 8  "57/56/56"
put_template 9  "ea/33/5b"
put_template 10 "95/ca/9a"
put_template 11 "f7/cd/94"
put_template 12 "93/aa/dd"
put_template 13 "bf/94/e5"
put_template 14 "5f/aa/e9"
put_template 15 "ff/ff/ff"

color_foreground="cf/d2/d6"
color_background="29/2b/31"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cfd2d6"
  put_template_custom Ph "292b31"
  put_template_custom Pi "f7cd94"
  put_template_custom Pj "d5d5d5"
  put_template_custom Pk "224281"
  put_template_custom Pl "55bbf9"
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
