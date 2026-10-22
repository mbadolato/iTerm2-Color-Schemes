#!/bin/sh
# Lumina Nebula Light

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
put_template 0  "1f/2a/38"
put_template 1  "90/27/25"
put_template 2  "2e/72/41"
put_template 3  "99/60/00"
put_template 4  "34/63/9e"
put_template 5  "84/48/7f"
put_template 6  "00/65/7e"
put_template 7  "65/72/83"
put_template 8  "62/6d/7a"
put_template 9  "69/26/23"
put_template 10 "1a/5d/2f"
put_template 11 "7e/4e/00"
put_template 12 "21/4f/88"
put_template 13 "6e/35/69"
put_template 14 "00/50/64"
put_template 15 "84/91/a3"

color_foreground="1f/2a/38"
color_background="f6/f8/fb"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1f2a38"
  put_template_custom Ph "f6f8fb"
  put_template_custom Pi "1f2a38"
  put_template_custom Pj "d3e0e7"
  put_template_custom Pk "1f2a38"
  put_template_custom Pl "1f2a38"
  put_template_custom Pm "f6f8fb"
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
