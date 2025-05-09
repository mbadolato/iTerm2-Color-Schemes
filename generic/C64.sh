#!/bin/sh
# C64

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
put_template 0  "09/03/00"
put_template 1  "88/39/32"
put_template 2  "55/a0/49"
put_template 3  "bf/ce/72"
put_template 4  "40/31/8d"
put_template 5  "8b/3f/96"
put_template 6  "67/b6/bd"
put_template 7  "ff/ff/ff"
put_template 8  "00/00/00"
put_template 9  "88/39/32"
put_template 10 "55/a0/49"
put_template 11 "bf/ce/72"
put_template 12 "40/31/8d"
put_template 13 "8b/3f/96"
put_template 14 "67/b6/bd"
put_template 15 "f7/f7/f7"

color_foreground="78/69/c4"
color_background="40/31/8d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "7869c4"
  put_template_custom Ph "40318d"
  put_template_custom Pi "a5a2a2"
  put_template_custom Pj "7869c4"
  put_template_custom Pk "40318d"
  put_template_custom Pl "7869c4"
  put_template_custom Pm "40318d"
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
