#!/bin/sh
# Lumina Ember Light

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
put_template 0  "37/2b/1e"
put_template 1  "81/1d/1d"
put_template 2  "43/73/29"
put_template 3  "a0/61/16"
put_template 4  "25/6b/99"
put_template 5  "96/43/7b"
put_template 6  "00/72/85"
put_template 7  "7a/6c/5e"
put_template 8  "71/66/57"
put_template 9  "5c/1d/1b"
put_template 10 "35/5d/20"
put_template 11 "87/4e/01"
put_template 12 "00/57/85"
put_template 13 "78/37/63"
put_template 14 "00/5c/6c"
put_template 15 "9a/8b/7c"

color_foreground="37/2b/1e"
color_background="f9/f4/ea"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "372b1e"
  put_template_custom Ph "f9f4ea"
  put_template_custom Pi "372b1e"
  put_template_custom Pj "e6bba2"
  put_template_custom Pk "372b1e"
  put_template_custom Pl "372b1e"
  put_template_custom Pm "f9f4ea"
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
