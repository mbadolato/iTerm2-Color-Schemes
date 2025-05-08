#!/bin/sh
# synthwave-everything

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
put_template 0  "fe/fe/fe"
put_template 1  "f9/7e/72"
put_template 2  "72/f1/b8"
put_template 3  "fe/de/5d"
put_template 4  "6d/77/b3"
put_template 5  "c7/92/ea"
put_template 6  "f7/72/e0"
put_template 7  "fe/fe/fe"
put_template 8  "fe/fe/fe"
put_template 9  "f8/84/14"
put_template 10 "72/f1/b8"
put_template 11 "ff/f9/51"
put_template 12 "36/f9/f6"
put_template 13 "e1/ac/ff"
put_template 14 "f9/2a/ad"
put_template 15 "fe/fe/fe"

color_foreground="f0/ef/f1"
color_background="2a/21/39"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f0eff1"
  put_template_custom Ph "2a2139"
  put_template_custom Pi "f0eff1"
  put_template_custom Pj "181521"
  put_template_custom Pk "f0eff1"
  put_template_custom Pl "72f1b8"
  put_template_custom Pm "1a1a1a"
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
