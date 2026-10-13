#!/bin/sh
# Tumbling Stones

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
put_template 0  "a5/a4/a2"
put_template 1  "eb/65/5f"
put_template 2  "9f/b5/a5"
put_template 3  "d6/b5/a1"
put_template 4  "89/ae/bc"
put_template 5  "b6/a3/b2"
put_template 6  "8f/ba/c0"
put_template 7  "f1/e9/e2"
put_template 8  "c2/bf/bb"
put_template 9  "fa/81/77"
put_template 10 "b6/c9/b8"
put_template 11 "eb/ca/bb"
put_template 12 "a2/c4/cf"
put_template 13 "d0/b8/c5"
put_template 14 "a9/d0/d2"
put_template 15 "ff/f8/f0"

color_foreground="f1/e9/e2"
color_background="14/12/12"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f1e9e2"
  put_template_custom Ph "141212"
  put_template_custom Pi "fff5e6"
  put_template_custom Pj "553337"
  put_template_custom Pk "fff9ed"
  put_template_custom Pl "f05b54"
  put_template_custom Pm "141212"
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
