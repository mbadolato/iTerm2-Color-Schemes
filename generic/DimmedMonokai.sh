#!/bin/sh
# DimmedMonokai

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
put_template 0  "3a/3d/43"
put_template 1  "be/3f/48"
put_template 2  "87/9a/3b"
put_template 3  "c5/a6/35"
put_template 4  "4f/76/a1"
put_template 5  "85/5c/8d"
put_template 6  "57/8f/a4"
put_template 7  "b9/bc/ba"
put_template 8  "88/89/87"
put_template 9  "fb/00/1f"
put_template 10 "0f/72/2f"
put_template 11 "c4/70/33"
put_template 12 "18/6d/e3"
put_template 13 "fb/00/67"
put_template 14 "2e/70/6d"
put_template 15 "fd/ff/b9"

color_foreground="b9/bc/ba"
color_background="1f/1f/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b9bcba"
  put_template_custom Ph "1f1f1f"
  put_template_custom Pi "feffb2"
  put_template_custom Pj "2a2d32"
  put_template_custom Pk "b9bcba"
  put_template_custom Pl "f83e19"
  put_template_custom Pm "171717"
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
