#!/bin/sh
# Cobalt Foundry

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
put_template 0  "1a/21/29"
put_template 1  "e5/73/73"
put_template 2  "81/b3/66"
put_template 3  "d4/a9/5f"
put_template 4  "4f/95/e0"
put_template 5  "9d/85/cf"
put_template 6  "56/b3/c4"
put_template 7  "a2/b0/be"
put_template 8  "56/62/6f"
put_template 9  "ef/8f/8f"
put_template 10 "9c/c9/83"
put_template 11 "e5/c0/7e"
put_template 12 "74/ae/ec"
put_template 13 "b5/a0/e0"
put_template 14 "78/cb/da"
put_template 15 "e2/ea/f2"

color_foreground="c2/ce/db"
color_background="10/15/1c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c2cedb"
  put_template_custom Ph "10151c"
  put_template_custom Pi "c2cedb"
  put_template_custom Pj "1f3a5c"
  put_template_custom Pk "e2eaf2"
  put_template_custom Pl "4fa8ff"
  put_template_custom Pm "10151c"
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
