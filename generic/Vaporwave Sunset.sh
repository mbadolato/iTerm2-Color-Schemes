#!/bin/sh
# Vaporwave Sunset

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
put_template 0  "4b/3d/53"
put_template 1  "fb/71/85"
put_template 2  "2d/d4/bf"
put_template 3  "fb/92/3c"
put_template 4  "a7/8b/fa"
put_template 5  "22/d3/ee"
put_template 6  "ff/4f/d8"
put_template 7  "f0/ab/fc"
put_template 8  "56/3f/6e"
put_template 9  "fc/8d/9d"
put_template 10 "57/dd/cc"
put_template 11 "fc/a6/5f"
put_template 12 "b9/a2/fb"
put_template 13 "4e/dc/f1"
put_template 14 "ff/72/e0"
put_template 15 "ff/f7/ed"

color_foreground="ff/f7/ed"
color_background="18/08/27"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff7ed"
  put_template_custom Ph "180827"
  put_template_custom Pi "fff7ed"
  put_template_custom Pj "fff7ed"
  put_template_custom Pk "180827"
  put_template_custom Pl "fff7ed"
  put_template_custom Pm "180827"
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
