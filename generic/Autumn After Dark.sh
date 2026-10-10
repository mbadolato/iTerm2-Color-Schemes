#!/bin/sh
# Autumn After Dark

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
put_template 0  "c8/b6/a6"
put_template 1  "f1/8f/67"
put_template 2  "9a/c4/7c"
put_template 3  "e9/bf/55"
put_template 4  "83/b8/d0"
put_template 5  "c7/94/af"
put_template 6  "78/c4/b8"
put_template 7  "f8/e9/cf"
put_template 8  "cf/bf/b1"
put_template 9  "f3/9c/79"
put_template 10 "a6/cb/8c"
put_template 11 "ec/c7/69"
put_template 12 "92/c1/d6"
put_template 13 "ce/a1/b9"
put_template 14 "88/cb/c1"
put_template 15 "f9/ec/d5"

color_foreground="f8/e9/cf"
color_background="57/21/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8e9cf"
  put_template_custom Ph "57210d"
  put_template_custom Pi "ecc769"
  put_template_custom Pj "cfbfb1"
  put_template_custom Pk "93866f"
  put_template_custom Pl "f39c79"
  put_template_custom Pm "57210d"
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
