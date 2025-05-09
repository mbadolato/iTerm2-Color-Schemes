#!/bin/sh
# Paraiso Dark

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
put_template 0  "2f/1e/2e"
put_template 1  "ef/61/55"
put_template 2  "48/b6/85"
put_template 3  "fe/c4/18"
put_template 4  "06/b6/ef"
put_template 5  "81/5b/a4"
put_template 6  "5b/c4/bf"
put_template 7  "a3/9e/9b"
put_template 8  "77/6e/71"
put_template 9  "ef/61/55"
put_template 10 "48/b6/85"
put_template 11 "fe/c4/18"
put_template 12 "06/b6/ef"
put_template 13 "81/5b/a4"
put_template 14 "5b/c4/bf"
put_template 15 "e7/e9/db"

color_foreground="a3/9e/9b"
color_background="2f/1e/2e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "a39e9b"
  put_template_custom Ph "2f1e2e"
  put_template_custom Pi "a39e9b"
  put_template_custom Pj "4f424c"
  put_template_custom Pk "a39e9b"
  put_template_custom Pl "a39e9b"
  put_template_custom Pm "2f1e2e"
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
