#!/bin/sh
# Squirrelsong Dark

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
put_template 0  "35/2a/21"
put_template 1  "ac/49/3e"
put_template 2  "55/82/40"
put_template 3  "ce/b2/50"
put_template 4  "59/93/c2"
put_template 5  "7f/61/b3"
put_template 6  "4f/95/93"
put_template 7  "cf/ba/a5"
put_template 8  "6b/50/3c"
put_template 9  "ce/57/4a"
put_template 10 "71/99/55"
put_template 11 "e2/c3/58"
put_template 12 "63/a2/d6"
put_template 13 "96/72/d4"
put_template 14 "72/aa/a8"
put_template 15 "ed/d5/be"

color_foreground="ad/9c/8b"
color_background="35/2a/21"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ad9c8b"
  put_template_custom Ph "352a21"
  put_template_custom Pi "edd5be"
  put_template_custom Pj "574131"
  put_template_custom Pk "ad9c8b"
  put_template_custom Pl "ad9c8b"
  put_template_custom Pm "352a21"
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
