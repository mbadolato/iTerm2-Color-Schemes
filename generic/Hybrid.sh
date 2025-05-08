#!/bin/sh
# Hybrid

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
put_template 0  "2a/2e/33"
put_template 1  "b8/4d/51"
put_template 2  "b3/bf/5a"
put_template 3  "e4/b5/5e"
put_template 4  "6e/90/b0"
put_template 5  "a1/7e/ac"
put_template 6  "7f/bf/b4"
put_template 7  "b5/b9/b6"
put_template 8  "1d/1f/22"
put_template 9  "8d/2e/32"
put_template 10 "79/84/31"
put_template 11 "e5/8a/50"
put_template 12 "4b/6b/88"
put_template 13 "6e/50/79"
put_template 14 "4d/7b/74"
put_template 15 "5a/62/6a"

color_foreground="b7/bc/ba"
color_background="16/17/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b7bcba"
  put_template_custom Ph "161719"
  put_template_custom Pi "b7bcba"
  put_template_custom Pj "1e1f22"
  put_template_custom Pk "b7bcba"
  put_template_custom Pl "b7bcba"
  put_template_custom Pm "1e1f22"
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
