#!/bin/sh
# IBM 5153 CGA (Black)

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
put_template 1  "c4/00/00"
put_template 2  "00/c4/00"
put_template 3  "c4/7e/00"
put_template 4  "00/00/c4"
put_template 5  "c4/00/c4"
put_template 6  "00/c4/c4"
put_template 7  "c4/c4/c4"
put_template 8  "4e/4e/4e"
put_template 9  "dc/4e/4e"
put_template 10 "4e/dc/4e"
put_template 11 "f3/f3/4e"
put_template 12 "4e/4e/dc"
put_template 13 "f3/4e/f3"
put_template 14 "4e/f3/f3"
put_template 15 "ff/ff/ff"

color_foreground="c4/c4/c4"
color_background="00/00/00"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c4c4c4"
  put_template_custom Ph "000000"
  put_template_custom Pi "c4c4c4"
  put_template_custom Pj "c4c4c4"
  put_template_custom Pk "000000"
  put_template_custom Pl "c4c4c4"
  put_template_custom Pm "c4c4c4"
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
