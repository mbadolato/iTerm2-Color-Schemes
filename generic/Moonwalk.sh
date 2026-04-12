#!/bin/sh
# Moonwalk

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
put_template 0  "08/08/08"
put_template 1  "7a/00/47"
put_template 2  "14/5b/0e"
put_template 3  "73/3a/11"
put_template 4  "00/2f/a7"
put_template 5  "54/00/a8"
put_template 6  "00/56/6b"
put_template 7  "9c/95/8d"
put_template 8  "49/44/40"
put_template 9  "af/16/08"
put_template 10 "4c/61/29"
put_template 11 "7a/50/00"
put_template 12 "0d/50/c5"
put_template 13 "95/21/97"
put_template 14 "00/60/92"
put_template 15 "ff/ff/ff"

color_foreground="06/1f/4a"
color_background="e4/e2/e0"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "061f4a"
  put_template_custom Ph "e4e2e0"
  put_template_custom Pi "061f4a"
  put_template_custom Pj "b8d2e5"
  put_template_custom Pk "061f4a"
  put_template_custom Pl "061f4a"
  put_template_custom Pm "e4e2e0"
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
