#!/bin/sh
# Callie Light

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
put_template 0  "2b/1a/26"
put_template 1  "9e/52/51"
put_template 2  "3f/7b/4a"
put_template 3  "88/65/18"
put_template 4  "4b/6b/a6"
put_template 5  "98/52/70"
put_template 6  "02/7c/7d"
put_template 7  "8f/7a/87"
put_template 8  "6b/55/62"
put_template 9  "8a/41/40"
put_template 10 "2d/6a/39"
put_template 11 "75/54/02"
put_template 12 "3b/59/93"
put_template 13 "85/41/5f"
put_template 14 "00/68/69"
put_template 15 "dc/c8/d3"

color_foreground="55/41/4e"
color_background="fb/f5/f8"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "55414e"
  put_template_custom Ph "fbf5f8"
  put_template_custom Pi "55414e"
  put_template_custom Pj "e0ccd7"
  put_template_custom Pk "55414e"
  put_template_custom Pl "e45f97"
  put_template_custom Pm "2e0f20"
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
