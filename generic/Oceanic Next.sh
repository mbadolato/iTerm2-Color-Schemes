#!/bin/sh
# Oceanic Next

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
put_template 0  "16/2c/35"
put_template 1  "ec/5f/67"
put_template 2  "99/c7/94"
put_template 3  "fa/c8/63"
put_template 4  "66/99/cc"
put_template 5  "c5/94/c5"
put_template 6  "5f/b3/b3"
put_template 7  "ff/ff/ff"
put_template 8  "65/73/7e"
put_template 9  "ec/5f/67"
put_template 10 "99/c7/94"
put_template 11 "fa/c8/63"
put_template 12 "66/99/cc"
put_template 13 "c5/94/c5"
put_template 14 "5f/b3/b3"
put_template 15 "ff/ff/ff"

color_foreground="c0/c5/ce"
color_background="16/2c/35"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c0c5ce"
  put_template_custom Ph "162c35"
  put_template_custom Pi "c0c5ce"
  put_template_custom Pj "4f5b66"
  put_template_custom Pk "c0c5ce"
  put_template_custom Pl "c0c5ce"
  put_template_custom Pm "1b2b34"
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
