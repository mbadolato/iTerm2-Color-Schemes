#!/bin/sh
# Earthsong

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
put_template 0  "12/14/18"
put_template 1  "c9/42/34"
put_template 2  "85/c5/4c"
put_template 3  "f5/ae/2e"
put_template 4  "13/98/b9"
put_template 5  "d0/63/3d"
put_template 6  "50/95/52"
put_template 7  "e5/c6/aa"
put_template 8  "67/5f/54"
put_template 9  "ff/64/5a"
put_template 10 "98/e0/36"
put_template 11 "e0/d5/61"
put_template 12 "5f/da/ff"
put_template 13 "ff/92/69"
put_template 14 "84/f0/88"
put_template 15 "f6/f7/ec"

color_foreground="e5/c7/a9"
color_background="29/25/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e5c7a9"
  put_template_custom Ph "292520"
  put_template_custom Pi "f6f7ec"
  put_template_custom Pj "121418"
  put_template_custom Pk "e5c7a9"
  put_template_custom Pl "f6f7ec"
  put_template_custom Pm "292520"
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
