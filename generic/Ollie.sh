#!/bin/sh
# Ollie

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
put_template 1  "ac/2e/31"
put_template 2  "31/ac/61"
put_template 3  "ac/43/00"
put_template 4  "2d/57/ac"
put_template 5  "b0/85/28"
put_template 6  "1f/a6/ac"
put_template 7  "8a/8e/ac"
put_template 8  "5b/37/25"
put_template 9  "ff/3d/48"
put_template 10 "3b/ff/99"
put_template 11 "ff/5e/1e"
put_template 12 "44/88/ff"
put_template 13 "ff/c2/1d"
put_template 14 "1f/fa/ff"
put_template 15 "5b/6e/a7"

color_foreground="8a/8d/ae"
color_background="22/21/25"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "8a8dae"
  put_template_custom Ph "222125"
  put_template_custom Pi "5c6dac"
  put_template_custom Pj "1e3a66"
  put_template_custom Pk "8a8eac"
  put_template_custom Pl "5b6ea7"
  put_template_custom Pm "2a292d"
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
