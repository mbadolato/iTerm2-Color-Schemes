#!/bin/sh
# Acid Lime

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
put_template 0  "13/1d/0c"
put_template 1  "ff/33/44"
put_template 2  "97/e6/3c"
put_template 3  "ee/ff/5c"
put_template 4  "4d/ec/a0"
put_template 5  "a6/ff/6b"
put_template 6  "50/ff/b4"
put_template 7  "bf/e0/a4"
put_template 8  "4a/6b/36"
put_template 9  "ff/33/44"
put_template 10 "97/e6/3c"
put_template 11 "db/ff/45"
put_template 12 "4d/ec/a0"
put_template 13 "a6/ff/6b"
put_template 14 "50/ff/b4"
put_template 15 "d4/ef/bc"

color_foreground="d4/ef/bc"
color_background="08/0c/05"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d4efbc"
  put_template_custom Ph "080c05"
  put_template_custom Pi "d4efbc"
  put_template_custom Pj "1b2a10"
  put_template_custom Pk "545852"
  put_template_custom Pl "c2ff33"
  put_template_custom Pm "080c05"
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
