#!/bin/sh
# iceberg-dark

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
put_template 0  "1e/21/32"
put_template 1  "e2/78/78"
put_template 2  "b4/be/82"
put_template 3  "e2/a4/78"
put_template 4  "84/a0/c6"
put_template 5  "a0/93/c7"
put_template 6  "89/b8/c2"
put_template 7  "c6/c8/d1"
put_template 8  "6b/70/89"
put_template 9  "e9/89/89"
put_template 10 "c0/ca/8e"
put_template 11 "e9/b1/89"
put_template 12 "91/ac/d1"
put_template 13 "ad/a0/d3"
put_template 14 "95/c4/ce"
put_template 15 "d2/d4/de"

color_foreground="c6/c8/d1"
color_background="16/18/21"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c6c8d1"
  put_template_custom Ph "161821"
  put_template_custom Pi "c6c8d1"
  put_template_custom Pj "c6c8d1"
  put_template_custom Pk "161821"
  put_template_custom Pl "c6c8d1"
  put_template_custom Pm "161821"
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
