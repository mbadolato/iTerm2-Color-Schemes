#!/bin/sh
# iTerm2 Solarized Dark

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
put_template 0  "07/36/42"
put_template 1  "dc/32/2f"
put_template 2  "85/99/00"
put_template 3  "b5/89/00"
put_template 4  "26/8b/d2"
put_template 5  "d3/36/82"
put_template 6  "2a/a1/98"
put_template 7  "ee/e8/d5"
put_template 8  "00/2b/36"
put_template 9  "cb/4b/16"
put_template 10 "58/6e/75"
put_template 11 "65/7b/83"
put_template 12 "83/94/96"
put_template 13 "6c/71/c4"
put_template 14 "93/a1/a1"
put_template 15 "fd/f6/e3"

color_foreground="83/94/96"
color_background="00/2b/36"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "839496"
  put_template_custom Ph "002b36"
  put_template_custom Pi "93a1a1"
  put_template_custom Pj "073642"
  put_template_custom Pk "93a1a1"
  put_template_custom Pl "839496"
  put_template_custom Pm "073642"
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
