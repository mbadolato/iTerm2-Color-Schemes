#!/bin/sh
# Eventide

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
put_template 0  "ae/b8/c5"
put_template 1  "ff/72/72"
put_template 2  "62/d6/a5"
put_template 3  "ff/d1/66"
put_template 4  "79/aa/ff"
put_template 5  "c7/9a/ff"
put_template 6  "73/d9/e8"
put_template 7  "e6/ed/f3"
put_template 8  "c3/cc/d6"
put_template 9  "ff/92/92"
put_template 10 "82/e2/b8"
put_template 11 "ff/e0/8a"
put_template 12 "9b/bd/ff"
put_template 13 "da/b6/ff"
put_template 14 "96/e8/f1"
put_template 15 "ff/ff/ff"

color_foreground="e6/ed/f3"
color_background="0b/12/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6edf3"
  put_template_custom Ph "0b1220"
  put_template_custom Pi "ffb000"
  put_template_custom Pj "284361"
  put_template_custom Pk "f5f8fc"
  put_template_custom Pl "8ecbff"
  put_template_custom Pm "0b1220"
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
