#!/bin/sh
# Lumina Polaire Light

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
put_template 0  "17/32/3f"
put_template 1  "88/23/22"
put_template 2  "32/76/45"
put_template 3  "96/5a/1c"
put_template 4  "3e/53/72"
put_template 5  "88/4c/84"
put_template 6  "06/67/7c"
put_template 7  "58/74/83"
put_template 8  "55/6a/74"
put_template 9  "63/22/1f"
put_template 10 "1f/61/33"
put_template 11 "7f/47/00"
put_template 12 "17/3e/76"
put_template 13 "72/3a/6e"
put_template 14 "00/52/64"
put_template 15 "76/94/a4"

color_foreground="17/32/3f"
color_background="f0/f9/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "17323f"
  put_template_custom Ph "f0f9fa"
  put_template_custom Pi "17323f"
  put_template_custom Pj "b8d1de"
  put_template_custom Pk "17323f"
  put_template_custom Pl "17323f"
  put_template_custom Pm "f0f9fa"
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
