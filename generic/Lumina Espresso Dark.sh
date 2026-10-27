#!/bin/sh
# Lumina Espresso Dark

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
put_template 0  "23/19/11"
put_template 1  "cd/76/6e"
put_template 2  "95/d3/b1"
put_template 3  "ef/ca/86"
put_template 4  "96/bf/e9"
put_template 5  "db/ad/d6"
put_template 6  "90/ca/d1"
put_template 7  "c5/bf/b6"
put_template 8  "93/8a/81"
put_template 9  "db/96/8f"
put_template 10 "b5/eb/cd"
put_template 11 "ff/e4/b4"
put_template 12 "b5/d8/fd"
put_template 13 "f6/c6/f1"
put_template 14 "a9/e4/ec"
put_template 15 "e5/df/d6"

color_foreground="e5/df/d6"
color_background="1e/15/0e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e5dfd6"
  put_template_custom Ph "1e150e"
  put_template_custom Pi "e5dfd6"
  put_template_custom Pj "45383f"
  put_template_custom Pk "e5dfd6"
  put_template_custom Pl "e5dfd6"
  put_template_custom Pm "1e150e"
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
