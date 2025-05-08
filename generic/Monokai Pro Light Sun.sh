#!/bin/sh
# Monokai Pro Light Sun

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
put_template 0  "f8/ef/e7"
put_template 1  "ce/47/70"
put_template 2  "21/88/71"
put_template 3  "b1/68/03"
put_template 4  "d4/57/2b"
put_template 5  "68/51/a2"
put_template 6  "24/73/b6"
put_template 7  "2c/23/2e"
put_template 8  "a5/9c/9c"
put_template 9  "ce/47/70"
put_template 10 "21/88/71"
put_template 11 "b1/68/03"
put_template 12 "d4/57/2b"
put_template 13 "68/51/a2"
put_template 14 "24/73/b6"
put_template 15 "2c/23/2e"

color_foreground="2c/23/2e"
color_background="f8/ef/e7"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2c232e"
  put_template_custom Ph "f8efe7"
  put_template_custom Pi "2473b6"
  put_template_custom Pj "beb5b3"
  put_template_custom Pk "2c232e"
  put_template_custom Pl "72696d"
  put_template_custom Pm "72696d"
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
