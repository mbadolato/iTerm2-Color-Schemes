#!/bin/sh
# zenbones_light

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
put_template 0  "f0/ed/ec"
put_template 1  "a8/33/4c"
put_template 2  "4f/6c/31"
put_template 3  "94/49/27"
put_template 4  "28/64/86"
put_template 5  "88/50/7d"
put_template 6  "3b/89/92"
put_template 7  "2c/36/3c"
put_template 8  "cf/c1/ba"
put_template 9  "94/25/3e"
put_template 10 "3f/5a/22"
put_template 11 "80/3d/1c"
put_template 12 "1d/55/73"
put_template 13 "7b/3b/70"
put_template 14 "2b/74/7c"
put_template 15 "4f/5e/68"

color_foreground="2c/36/3c"
color_background="f0/ed/ec"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2c363c"
  put_template_custom Ph "f0edec"
  put_template_custom Pi "cfc1ba"
  put_template_custom Pj "cbd9e3"
  put_template_custom Pk "2c363c"
  put_template_custom Pl "2c363c"
  put_template_custom Pm "f0edec"
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
