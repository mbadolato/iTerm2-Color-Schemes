#!/bin/sh
# Rhoads LP

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
put_template 0  "3b/35/25"
put_template 1  "c5/42/3a"
put_template 2  "5f/8f/4f"
put_template 3  "d6/b8/52"
put_template 4  "5b/7f/d6"
put_template 5  "a6/78/d6"
put_template 6  "46/c5/c3"
put_template 7  "c2/bc/b0"
put_template 8  "8a/84/74"
put_template 9  "e6/6f/67"
put_template 10 "91/bd/79"
put_template 11 "ce/b3/52"
put_template 12 "86/a5/e8"
put_template 13 "c3/9b/e8"
put_template 14 "68/bf/bb"
put_template 15 "ff/fe/f9"

color_foreground="2b/26/18"
color_background="fd/f7/e8"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2b2618"
  put_template_custom Ph "fdf7e8"
  put_template_custom Pi "c9a646"
  put_template_custom Pj "e0c878"
  put_template_custom Pk "80651f"
  put_template_custom Pl "d4b34f"
  put_template_custom Pm "fffaf0"
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
