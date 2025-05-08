#!/bin/sh
# Royal

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
put_template 0  "24/1f/2b"
put_template 1  "91/28/4c"
put_template 2  "23/80/1c"
put_template 3  "b4/9d/27"
put_template 4  "65/80/b0"
put_template 5  "67/4d/96"
put_template 6  "8a/aa/be"
put_template 7  "52/49/66"
put_template 8  "31/2d/3d"
put_template 9  "d5/35/6c"
put_template 10 "2c/d9/46"
put_template 11 "fd/e8/3b"
put_template 12 "90/ba/f9"
put_template 13 "a4/79/e3"
put_template 14 "ac/d4/eb"
put_template 15 "9e/8c/bd"

color_foreground="51/49/68"
color_background="10/08/15"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "514968"
  put_template_custom Ph "100815"
  put_template_custom Pi "c8bd1d"
  put_template_custom Pj "1f1d2b"
  put_template_custom Pk "a593cd"
  put_template_custom Pl "524966"
  put_template_custom Pm "100613"
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
