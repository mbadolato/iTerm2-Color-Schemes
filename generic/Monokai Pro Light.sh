#!/bin/sh
# Monokai Pro Light

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
put_template 0  "fa/f4/f2"
put_template 1  "e1/47/75"
put_template 2  "26/9d/69"
put_template 3  "cc/7a/0a"
put_template 4  "e1/60/32"
put_template 5  "70/58/be"
put_template 6  "1c/8c/a8"
put_template 7  "29/24/2a"
put_template 8  "a5/9f/a0"
put_template 9  "e1/47/75"
put_template 10 "26/9d/69"
put_template 11 "cc/7a/0a"
put_template 12 "e1/60/32"
put_template 13 "70/58/be"
put_template 14 "1c/8c/a8"
put_template 15 "29/24/2a"

color_foreground="29/24/2a"
color_background="fa/f4/f2"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "29242a"
  put_template_custom Ph "faf4f2"
  put_template_custom Pi "1c8ca8"
  put_template_custom Pj "bfb9ba"
  put_template_custom Pk "29242a"
  put_template_custom Pl "706b6e"
  put_template_custom Pm "706b6e"
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
