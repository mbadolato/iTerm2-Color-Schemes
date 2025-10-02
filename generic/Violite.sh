#!/bin/sh
# Violite

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
put_template 0  "24/1c/36"
put_template 1  "ec/79/79"
put_template 2  "79/ec/b3"
put_template 3  "ec/e2/79"
put_template 4  "a9/79/ec"
put_template 5  "ec/79/ec"
put_template 6  "79/ec/ec"
put_template 7  "ee/f4/f6"
put_template 8  "56/44/7a"
put_template 9  "ef/8f/8f"
put_template 10 "9f/ef/bf"
put_template 11 "ef/e7/8f"
put_template 12 "b7/8f/ef"
put_template 13 "ef/8f/cf"
put_template 14 "9f/ef/ef"
put_template 15 "f8/fa/fc"

color_foreground="ee/f4/f6"
color_background="24/1c/36"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eef4f6"
  put_template_custom Ph "241c36"
  put_template_custom Pi "eef4f6"
  put_template_custom Pj "49376d"
  put_template_custom Pk "eef4f6"
  put_template_custom Pl "eef4f6"
  put_template_custom Pm "241c36"
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
