#!/bin/sh
# starlight

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
put_template 0  "24/24/24"
put_template 1  "f6/2b/5a"
put_template 2  "47/b4/13"
put_template 3  "e3/c4/01"
put_template 4  "24/ac/d4"
put_template 5  "f2/af/fd"
put_template 6  "13/c2/99"
put_template 7  "e6/e6/e6"
put_template 8  "61/61/61"
put_template 9  "ff/4d/51"
put_template 10 "35/d4/50"
put_template 11 "e9/e8/36"
put_template 12 "5d/c5/f8"
put_template 13 "fe/ab/f2"
put_template 14 "24/df/c4"
put_template 15 "ff/ff/ff"

color_foreground="ff/ff/ff"
color_background="24/24/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffffff"
  put_template_custom Ph "242424"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "ffffff"
  put_template_custom Pk "242424"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "242424"
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
