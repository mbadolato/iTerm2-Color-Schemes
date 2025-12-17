#!/bin/sh
# Onenord

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
put_template 0  "3b/42/52"
put_template 1  "e0/6c/75"
put_template 2  "9e/c1/83"
put_template 3  "eb/cb/8b"
put_template 4  "81/a1/c1"
put_template 5  "b9/88/b0"
put_template 6  "88/c0/d0"
put_template 7  "e5/e9/f0"
put_template 8  "59/63/77"
put_template 9  "e0/6c/75"
put_template 10 "9e/c1/83"
put_template 11 "eb/cb/8b"
put_template 12 "81/a1/c1"
put_template 13 "b9/88/b0"
put_template 14 "8f/bc/bb"
put_template 15 "ec/ef/f4"

color_foreground="e5/e9/f0"
color_background="2e/34/40"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e5e9f0"
  put_template_custom Ph "2e3440"
  put_template_custom Pi "eceff4"
  put_template_custom Pj "434c5e"
  put_template_custom Pk "d8dee9"
  put_template_custom Pl "81a1c1"
  put_template_custom Pm "3b4252"
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
