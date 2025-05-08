#!/bin/sh
# Monokai Classic

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
put_template 0  "27/28/22"
put_template 1  "f9/26/72"
put_template 2  "a6/e2/2e"
put_template 3  "e6/db/74"
put_template 4  "fd/97/1f"
put_template 5  "ae/81/ff"
put_template 6  "66/d9/ef"
put_template 7  "fd/ff/f1"
put_template 8  "6e/70/66"
put_template 9  "f9/26/72"
put_template 10 "a6/e2/2e"
put_template 11 "e6/db/74"
put_template 12 "fd/97/1f"
put_template 13 "ae/81/ff"
put_template 14 "66/d9/ef"
put_template 15 "fd/ff/f1"

color_foreground="fd/ff/f1"
color_background="27/28/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fdfff1"
  put_template_custom Ph "272822"
  put_template_custom Pi "66d9ef"
  put_template_custom Pj "57584f"
  put_template_custom Pk "fdfff1"
  put_template_custom Pl "c0c1b5"
  put_template_custom Pm "c0c1b5"
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
