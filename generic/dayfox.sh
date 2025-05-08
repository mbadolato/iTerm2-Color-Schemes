#!/bin/sh
# dayfox

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
put_template 0  "35/2c/24"
put_template 1  "a5/22/2f"
put_template 2  "39/68/47"
put_template 3  "ac/54/02"
put_template 4  "28/48/a9"
put_template 5  "6e/33/ce"
put_template 6  "28/79/80"
put_template 7  "f2/e9/e1"
put_template 8  "53/4c/45"
put_template 9  "b3/43/4e"
put_template 10 "57/7f/63"
put_template 11 "b8/6e/28"
put_template 12 "48/63/b6"
put_template 13 "84/52/d5"
put_template 14 "48/8d/93"
put_template 15 "f4/ec/e6"

color_foreground="3d/2b/5a"
color_background="f6/f2/ee"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3d2b5a"
  put_template_custom Ph "f6f2ee"
  put_template_custom Pi "3d2b5a"
  put_template_custom Pj "e7d2be"
  put_template_custom Pk "3d2b5a"
  put_template_custom Pl "3d2b5a"
  put_template_custom Pm "f6f2ee"
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
