#!/bin/sh
# electron-highlighter

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
put_template 0  "15/16/1e"
put_template 1  "f7/76/8e"
put_template 2  "58/ff/c7"
put_template 3  "ff/d9/af"
put_template 4  "82/aa/ff"
put_template 5  "d2/a6/ef"
put_template 6  "57/f9/ff"
put_template 7  "7c/8e/ac"
put_template 8  "50/66/86"
put_template 9  "f7/76/8e"
put_template 10 "58/ff/c7"
put_template 11 "ff/d9/af"
put_template 12 "82/aa/ff"
put_template 13 "d2/a6/ef"
put_template 14 "57/f9/ff"
put_template 15 "c5/ce/e0"

color_foreground="a8/b5/d1"
color_background="24/28/3b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "a8b5d1"
  put_template_custom Ph "24283b"
  put_template_custom Pi "aab5cf"
  put_template_custom Pj "283457"
  put_template_custom Pk "a8b5d1"
  put_template_custom Pl "a8b5d1"
  put_template_custom Pm "1a1b26"
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
