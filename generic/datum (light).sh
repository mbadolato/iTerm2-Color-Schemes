#!/bin/sh
# datum (light)

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
put_template 0  "29/2e/35"
put_template 1  "a4/46/02"
put_template 2  "10/7c/5a"
put_template 3  "75/6f/1d"
put_template 4  "00/68/a4"
put_template 5  "98/34/72"
put_template 6  "0b/7b/80"
put_template 7  "b4/b9/bf"
put_template 8  "61/6a/76"
put_template 9  "97/67/00"
put_template 10 "10/7c/5a"
put_template 11 "4d/39/19"
put_template 12 "2f/51/6c"
put_template 13 "63/37/50"
put_template 14 "15/4b/4e"
put_template 15 "e7/ec/f2"

color_foreground="29/2e/35"
color_background="f1/f6/fd"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "292e35"
  put_template_custom Ph "f1f6fd"
  put_template_custom Pi "292e35"
  put_template_custom Pj "ced3d9"
  put_template_custom Pk "292e35"
  put_template_custom Pl "983472"
  put_template_custom Pm "f1f6fd"
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
