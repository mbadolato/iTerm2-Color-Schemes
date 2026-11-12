#!/bin/sh
# Termius Dark

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
put_template 0  "34/38/51"
put_template 1  "f2/4e/50"
put_template 2  "00/84/63"
put_template 3  "ec/a8/55"
put_template 4  "08/63/9f"
put_template 5  "c1/32/82"
put_template 6  "20/91/f6"
put_template 7  "e2/e3/e8"
put_template 8  "8d/91/a5"
put_template 9  "ff/73/75"
put_template 10 "3e/d7/be"
put_template 11 "fd/c4/7d"
put_template 12 "6b/a0/c3"
put_template 13 "ff/7d/c5"
put_template 14 "44/a7/ff"
put_template 15 "ff/ff/ff"

color_foreground="21/b5/68"
color_background="14/17/29"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "21b568"
  put_template_custom Ph "141729"
  put_template_custom Pi "21b568"
  put_template_custom Pj "1b6649"
  put_template_custom Pk "21b568"
  put_template_custom Pl "21b568"
  put_template_custom Pm "141729"
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
