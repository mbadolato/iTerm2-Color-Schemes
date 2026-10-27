#!/bin/sh
# Lumina Dusk Light

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
put_template 0  "2e/29/45"
put_template 1  "87/24/23"
put_template 2  "35/75/45"
put_template 3  "9e/61/1b"
put_template 4  "31/63/ad"
put_template 5  "87/4d/82"
put_template 6  "00/71/85"
put_template 7  "70/6b/8b"
put_template 8  "69/63/7b"
put_template 9  "62/23/20"
put_template 10 "21/60/33"
put_template 11 "85/4e/07"
put_template 12 "2b/50/88"
put_template 13 "71/3a/6c"
put_template 14 "00/5b/6c"
put_template 15 "8e/8a/ac"

color_foreground="2e/29/45"
color_background="f6/f3/fe"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2e2945"
  put_template_custom Ph "f6f3fe"
  put_template_custom Pi "2e2945"
  put_template_custom Pj "d7bcc6"
  put_template_custom Pk "2e2945"
  put_template_custom Pl "2e2945"
  put_template_custom Pm "f6f3fe"
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
