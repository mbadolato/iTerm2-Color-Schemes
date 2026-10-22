#!/bin/sh
# Lumina Parchment Light

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
put_template 0  "30/24/16"
put_template 1  "81/1d/1d"
put_template 2  "1b/47/32"
put_template 3  "90/5c/00"
put_template 4  "2b/5a/94"
put_template 5  "83/2f/6f"
put_template 6  "00/64/76"
put_template 7  "74/66/57"
put_template 8  "70/64/53"
put_template 9  "5c/1d/1b"
put_template 10 "00/35/20"
put_template 11 "76/4a/00"
put_template 12 "17/46/7e"
put_template 13 "64/29/55"
put_template 14 "00/4f/5e"
put_template 15 "93/84/74"

color_foreground="30/24/16"
color_background="f3/e9/d2"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "302416"
  put_template_custom Ph "f3e9d2"
  put_template_custom Pi "302416"
  put_template_custom Pj "b6c3b1"
  put_template_custom Pk "302416"
  put_template_custom Pl "302416"
  put_template_custom Pm "f3e9d2"
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
