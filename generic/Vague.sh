#!/bin/sh
# Vague

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
put_template 0  "14/14/15"
put_template 1  "df/68/82"
put_template 2  "8c/b6/6d"
put_template 3  "f3/be/7c"
put_template 4  "7e/98/e8"
put_template 5  "c3/c3/d5"
put_template 6  "9b/b4/bc"
put_template 7  "cd/cd/cd"
put_template 8  "87/87/87"
put_template 9  "df/68/82"
put_template 10 "8c/b6/6d"
put_template 11 "f3/be/7c"
put_template 12 "7e/98/e8"
put_template 13 "c3/c3/d5"
put_template 14 "9b/b4/bc"
put_template 15 "cd/cd/cd"

color_foreground="cd/cd/cd"
color_background="14/14/15"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cdcdcd"
  put_template_custom Ph "141415"
  put_template_custom Pi "cdcdcd"
  put_template_custom Pj "878787"
  put_template_custom Pk "cdcdcd"
  put_template_custom Pl "cdcdcd"
  put_template_custom Pm "141415"
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
