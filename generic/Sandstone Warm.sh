#!/bin/sh
# Sandstone Warm

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
put_template 0  "2e/20/10"
put_template 1  "cf/25/22"
put_template 2  "5d/7b/00"
put_template 3  "86/5e/00"
put_template 4  "0d/6e/b2"
put_template 5  "b5/2d/6e"
put_template 6  "03/7a/71"
put_template 7  "75/6c/51"
put_template 8  "5c/4a/2a"
put_template 9  "c0/40/10"
put_template 10 "7f/66/48"
put_template 11 "7d/66/46"
put_template 12 "5c/6f/6f"
put_template 13 "5f/64/b7"
put_template 14 "5f/6e/6e"
put_template 15 "fd/f6/e3"

color_foreground="3e/32/20"
color_background="fd/f6/e3"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3e3220"
  put_template_custom Ph "fdf6e3"
  put_template_custom Pi "3e3220"
  put_template_custom Pj "e8dfc4"
  put_template_custom Pk "b0a996"
  put_template_custom Pl "3e3220"
  put_template_custom Pm "fdf6e3"
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
