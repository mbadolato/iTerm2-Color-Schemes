#!/bin/sh
# Broadcast

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
put_template 0  "00/00/00"
put_template 1  "da/49/39"
put_template 2  "51/9f/50"
put_template 3  "ff/d2/4a"
put_template 4  "6d/9c/be"
put_template 5  "d0/d0/ff"
put_template 6  "6e/9c/be"
put_template 7  "ff/ff/ff"
put_template 8  "32/32/32"
put_template 9  "ff/7b/6b"
put_template 10 "83/d1/82"
put_template 11 "ff/ff/7c"
put_template 12 "9f/ce/f0"
put_template 13 "ff/ff/ff"
put_template 14 "a0/ce/f0"
put_template 15 "ff/ff/ff"

color_foreground="e6/e1/dc"
color_background="2b/2b/2b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e1dc"
  put_template_custom Ph "2b2b2b"
  put_template_custom Pi "e6e1dc"
  put_template_custom Pj "5a647e"
  put_template_custom Pk "e6e1dc"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "e6e1dc"
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
