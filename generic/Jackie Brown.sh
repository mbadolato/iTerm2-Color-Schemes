#!/bin/sh
# Jackie Brown

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
put_template 0  "2c/1d/16"
put_template 1  "ef/57/34"
put_template 2  "2b/af/2b"
put_template 3  "be/bf/00"
put_template 4  "24/6e/b2"
put_template 5  "d0/5e/c1"
put_template 6  "00/ac/ee"
put_template 7  "bf/bf/bf"
put_template 8  "66/66/66"
put_template 9  "e5/00/00"
put_template 10 "86/a9/3e"
put_template 11 "e5/e5/00"
put_template 12 "00/00/ff"
put_template 13 "e5/00/e5"
put_template 14 "00/e5/e5"
put_template 15 "e5/e5/e5"

color_foreground="ff/cc/2f"
color_background="2c/1d/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffcc2f"
  put_template_custom Ph "2c1d16"
  put_template_custom Pi "ffcc2f"
  put_template_custom Pj "af8d21"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "23ff18"
  put_template_custom Pm "ff0018"
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
