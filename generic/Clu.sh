#!/bin/sh
# Clu

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
put_template 0  "21/17/0c"
put_template 1  "f6/00/04"
put_template 2  "00/b5/e4"
put_template 3  "ff/ff/0f"
put_template 4  "e9/67/00"
put_template 5  "e9/67/00"
put_template 6  "ff/ff/ff"
put_template 7  "00/b5/e4"
put_template 8  "65/33/33"
put_template 9  "f6/00/04"
put_template 10 "ff/ff/ff"
put_template 11 "ff/ff/ff"
put_template 12 "00/b5/e4"
put_template 13 "f6/00/04"
put_template 14 "f6/00/04"
put_template 15 "e9/67/00"

color_foreground="fd/d4/8d"
color_background="00/0d/15"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fdd48d"
  put_template_custom Ph "000d15"
  put_template_custom Pi "fdd48d"
  put_template_custom Pj "3c0000"
  put_template_custom Pk "fdd48d"
  put_template_custom Pl "00b5e4"
  put_template_custom Pm "000d15"
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
