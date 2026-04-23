#!/bin/sh
# JetCalm Light

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
put_template 0  "38/3a/42"
put_template 1  "a5/2a/2a"
put_template 2  "55/6b/2f"
put_template 3  "5c/3e/00"
put_template 4  "46/82/b4"
put_template 5  "a6/26/a4"
put_template 6  "09/97/b3"
put_template 7  "6b/8e/23"
put_template 8  "4f/52/5d"
put_template 9  "df/6c/75"
put_template 10 "2e/8b/57"
put_template 11 "80/80/00"
put_template 12 "00/80/80"
put_template 13 "c5/77/dd"
put_template 14 "00/80/80"
put_template 15 "7b/8d/9e"

color_foreground="1c/24/10"
color_background="ed/ed/ed"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1c2410"
  put_template_custom Ph "ededed"
  put_template_custom Pi "1c2410"
  put_template_custom Pj "3c444d"
  put_template_custom Pk "ededed"
  put_template_custom Pl "082108"
  put_template_custom Pm "ededed"
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
