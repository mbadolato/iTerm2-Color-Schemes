#!/bin/sh
# Daybreak

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
put_template 0  "44/41/3b"
put_template 1  "af/28/17"
put_template 2  "3c/6a/12"
put_template 3  "79/59/00"
put_template 4  "18/68/75"
put_template 5  "75/41/93"
put_template 6  "00/6a/62"
put_template 7  "6e/6b/62"
put_template 8  "8c/85/79"
put_template 9  "c0/3a/27"
put_template 10 "53/86/25"
put_template 11 "9a/4c/1f"
put_template 12 "20/78/87"
put_template 13 "85/52/a3"
put_template 14 "08/7a/71"
put_template 15 "2e/2c/27"

color_foreground="44/41/3b"
color_background="f3/ef/e8"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "44413b"
  put_template_custom Ph "f3efe8"
  put_template_custom Pi "44413b"
  put_template_custom Pj "e2daca"
  put_template_custom Pk "a6a29b"
  put_template_custom Pl "a25327"
  put_template_custom Pm "f3efe8"
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
