#!/bin/sh
# Pyrokai Light

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
put_template 0  "24/21/20"
put_template 1  "b8/49/63"
put_template 2  "56/84/13"
put_template 3  "8e/71/00"
put_template 4  "09/79/c4"
put_template 5  "b4/4a/74"
put_template 6  "00/84/90"
put_template 7  "b4/af/ad"
put_template 8  "80/7c/7a"
put_template 9  "94/3c/50"
put_template 10 "45/6a/13"
put_template 11 "73/5a/00"
put_template 12 "0f/61/9d"
put_template 13 "91/3c/5d"
put_template 14 "00/6a/74"
put_template 15 "fa/f6/f5"

color_foreground="24/21/20"
color_background="fa/f6/f5"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "242120"
  put_template_custom Ph "faf6f5"
  put_template_custom Pi "242120"
  put_template_custom Pj "e4e0de"
  put_template_custom Pk "242120"
  put_template_custom Pl "b65318"
  put_template_custom Pm "faf6f5"
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
