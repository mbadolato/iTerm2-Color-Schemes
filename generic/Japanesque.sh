#!/bin/sh
# Japanesque

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
put_template 0  "34/39/35"
put_template 1  "cf/3f/61"
put_template 2  "7b/b7/5b"
put_template 3  "e9/b3/2a"
put_template 4  "4c/9a/d4"
put_template 5  "a5/7f/c4"
put_template 6  "38/9a/ad"
put_template 7  "fa/fa/f6"
put_template 8  "59/5b/59"
put_template 9  "d1/8f/a6"
put_template 10 "76/7f/2c"
put_template 11 "78/59/2f"
put_template 12 "13/59/79"
put_template 13 "60/42/91"
put_template 14 "76/bb/ca"
put_template 15 "b2/b5/ae"

color_foreground="f7/f6/ec"
color_background="1e/1e/1e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7f6ec"
  put_template_custom Ph "1e1e1e"
  put_template_custom Pi "fffffa"
  put_template_custom Pj "175877"
  put_template_custom Pk "f7f6ec"
  put_template_custom Pl "edcf4f"
  put_template_custom Pm "343935"
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
