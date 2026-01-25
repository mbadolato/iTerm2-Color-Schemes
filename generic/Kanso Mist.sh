#!/bin/sh
# Kanso Mist

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
put_template 0  "22/26/2d"
put_template 1  "c4/74/6e"
put_template 2  "8a/9a/7b"
put_template 3  "c4/b2/8a"
put_template 4  "8b/a4/b0"
put_template 5  "a2/92/a3"
put_template 6  "8e/a4/a2"
put_template 7  "a4/a7/a4"
put_template 8  "5c/60/66"
put_template 9  "e4/68/76"
put_template 10 "87/a9/87"
put_template 11 "e6/c3/84"
put_template 12 "7f/b4/ca"
put_template 13 "93/8a/a9"
put_template 14 "7a/a8/9f"
put_template 15 "c5/c9/c7"

color_foreground="c5/c9/c7"
color_background="22/26/2d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c5c9c7"
  put_template_custom Ph "22262d"
  put_template_custom Pi "c5c9c7"
  put_template_custom Pj "43464e"
  put_template_custom Pk "c5c9c7"
  put_template_custom Pl "c5c9c7"
  put_template_custom Pm "22262d"
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
