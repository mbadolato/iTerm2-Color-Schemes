#!/bin/sh
# Lumina Quartz Light Contrast

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
put_template 0  "0e/0f/13"
put_template 1  "66/00/05"
put_template 2  "00/58/1f"
put_template 3  "7e/48/00"
put_template 4  "00/4b/7a"
put_template 5  "72/24/6e"
put_template 6  "00/54/63"
put_template 7  "72/74/79"
put_template 8  "59/5f/64"
put_template 9  "47/01/03"
put_template 10 "00/42/15"
put_template 11 "64/38/00"
put_template 12 "00/38/5d"
put_template 13 "5b/0f/58"
put_template 14 "00/40/4b"
put_template 15 "92/93/99"

color_foreground="0e/0f/13"
color_background="fd/fd/fe"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "0e0f13"
  put_template_custom Ph "fdfdfe"
  put_template_custom Pi "0e0f13"
  put_template_custom Pj "b7d0d5"
  put_template_custom Pk "0e0f13"
  put_template_custom Pl "0e0f13"
  put_template_custom Pm "fdfdfe"
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
