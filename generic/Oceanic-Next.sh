#!/bin/sh
# Oceanic-Next

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
put_template 0  "1b/2b/34"
put_template 1  "db/68/6b"
put_template 2  "a2/c6/99"
put_template 3  "f2/ca/73"
put_template 4  "71/98/c8"
put_template 5  "bd/96/c2"
put_template 6  "74/b1/b2"
put_template 7  "ff/ff/ff"
put_template 8  "68/73/7d"
put_template 9  "db/68/6b"
put_template 10 "a2/c6/99"
put_template 11 "f2/ca/73"
put_template 12 "71/98/c8"
put_template 13 "bd/96/c2"
put_template 14 "74/b1/b2"
put_template 15 "ff/ff/ff"

color_foreground="c1/c5/cd"
color_background="1b/2b/34"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c1c5cd"
  put_template_custom Ph "1b2b34"
  put_template_custom Pi "c1c5cd"
  put_template_custom Pj "515b65"
  put_template_custom Pk "c1c5cd"
  put_template_custom Pl "c1c5cd"
  put_template_custom Pm "1e2b33"
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
