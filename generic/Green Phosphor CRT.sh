#!/bin/sh
# Green Phosphor CRT

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
put_template 0  "00/22/00"
put_template 1  "00/aa/00"
put_template 2  "33/ff/33"
put_template 3  "66/ff/66"
put_template 4  "00/cc/44"
put_template 5  "00/ff/88"
put_template 6  "66/ff/aa"
put_template 7  "b6/ff/b6"
put_template 8  "0a/5a/0a"
put_template 9  "19/cc/19"
put_template 10 "66/ff/66"
put_template 11 "99/ff/99"
put_template 12 "33/ff/77"
put_template 13 "66/ff/aa"
put_template 14 "99/ff/cc"
put_template 15 "e6/ff/e6"

color_foreground="33/ff/33"
color_background="0b/0f/0b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "33ff33"
  put_template_custom Ph "0b0f0b"
  put_template_custom Pi "33ff33"
  put_template_custom Pj "0a3a0a"
  put_template_custom Pk "575b57"
  put_template_custom Pl "33ff33"
  put_template_custom Pm "0b0f0b"
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
