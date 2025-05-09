#!/bin/sh
# purplepeter

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
put_template 0  "0a/05/20"
put_template 1  "ff/79/6d"
put_template 2  "99/b4/81"
put_template 3  "ef/df/ac"
put_template 4  "66/d9/ef"
put_template 5  "e7/8f/cd"
put_template 6  "ba/8c/ff"
put_template 7  "ff/ba/81"
put_template 8  "10/0b/23"
put_template 9  "f9/9f/92"
put_template 10 "b4/be/8f"
put_template 11 "f2/e9/bf"
put_template 12 "79/da/ed"
put_template 13 "ba/91/d4"
put_template 14 "a0/a0/d6"
put_template 15 "b9/ae/d3"

color_foreground="ec/e7/fa"
color_background="2a/1a/4a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ece7fa"
  put_template_custom Ph "2a1a4a"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "8689c2"
  put_template_custom Pk "271c50"
  put_template_custom Pl "c7c7c7"
  put_template_custom Pm "ffffff"
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
