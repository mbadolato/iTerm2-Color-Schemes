#!/bin/sh
# kanagawabones

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
put_template 0  "1f/1f/28"
put_template 1  "e4/6a/78"
put_template 2  "98/bc/6d"
put_template 3  "e5/c2/83"
put_template 4  "7e/b3/c9"
put_template 5  "95/7f/b8"
put_template 6  "7e/b3/c9"
put_template 7  "dd/d8/bb"
put_template 8  "3c/3c/51"
put_template 9  "ec/81/8c"
put_template 10 "9e/c9/67"
put_template 11 "f1/c9/82"
put_template 12 "7b/c2/df"
put_template 13 "a9/8f/d2"
put_template 14 "7b/c2/df"
put_template 15 "a8/a4/8d"

color_foreground="dd/d8/bb"
color_background="1f/1f/28"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ddd8bb"
  put_template_custom Ph "1f1f28"
  put_template_custom Pi "3c3c51"
  put_template_custom Pj "49473e"
  put_template_custom Pk "ddd8bb"
  put_template_custom Pl "e6e0c2"
  put_template_custom Pm "1f1f28"
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
