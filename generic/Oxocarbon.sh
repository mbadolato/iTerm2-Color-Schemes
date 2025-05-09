#!/bin/sh
# Oxocarbon

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
put_template 0  "16/16/16"
put_template 1  "3d/db/d9"
put_template 2  "33/b1/ff"
put_template 3  "ee/53/96"
put_template 4  "42/be/65"
put_template 5  "be/95/ff"
put_template 6  "ff/7e/b6"
put_template 7  "f2/f4/f8"
put_template 8  "58/58/58"
put_template 9  "3d/db/d9"
put_template 10 "33/b1/ff"
put_template 11 "ee/53/96"
put_template 12 "42/be/65"
put_template 13 "be/95/ff"
put_template 14 "ff/7e/b6"
put_template 15 "f2/f4/f8"

color_foreground="f2/f4/f8"
color_background="16/16/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2f4f8"
  put_template_custom Ph "161616"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "393939"
  put_template_custom Pk "161616"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "000000"
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
