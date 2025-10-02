#!/bin/sh
# Gruvbox Material Light

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
put_template 0  "fb/f1/c7"
put_template 1  "c1/4a/4a"
put_template 2  "6c/78/2e"
put_template 3  "b4/71/09"
put_template 4  "45/70/7a"
put_template 5  "94/5e/80"
put_template 6  "4c/7a/5d"
put_template 7  "65/47/35"
put_template 8  "a8/99/84"
put_template 9  "c1/4a/4a"
put_template 10 "6c/78/2e"
put_template 11 "b4/71/09"
put_template 12 "45/70/7a"
put_template 13 "94/5e/80"
put_template 14 "4c/7a/5d"
put_template 15 "4f/38/29"

color_foreground="65/47/35"
color_background="fb/f1/c7"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "654735"
  put_template_custom Ph "fbf1c7"
  put_template_custom Pi "654735"
  put_template_custom Pj "654735"
  put_template_custom Pk "fbf1c7"
  put_template_custom Pl "654735"
  put_template_custom Pm "8b6d5b"
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
