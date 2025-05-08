#!/bin/sh
# FishTank

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
put_template 0  "03/07/3c"
put_template 1  "c6/00/4a"
put_template 2  "ac/f1/57"
put_template 3  "fe/cd/5e"
put_template 4  "52/5f/b8"
put_template 5  "98/6f/82"
put_template 6  "96/87/63"
put_template 7  "ec/f0/fc"
put_template 8  "6c/5b/30"
put_template 9  "da/4b/8a"
put_template 10 "db/ff/a9"
put_template 11 "fe/e6/a9"
put_template 12 "b2/be/fa"
put_template 13 "fd/a5/cd"
put_template 14 "a5/bd/86"
put_template 15 "f6/ff/ec"

color_foreground="ec/f0/fe"
color_background="23/25/37"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ecf0fe"
  put_template_custom Ph "232537"
  put_template_custom Pi "f6ffeb"
  put_template_custom Pj "fcf7e9"
  put_template_custom Pk "232537"
  put_template_custom Pl "fecd5e"
  put_template_custom Pm "232537"
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
