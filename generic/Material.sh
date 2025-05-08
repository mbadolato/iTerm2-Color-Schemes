#!/bin/sh
# Material

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
put_template 0  "21/21/21"
put_template 1  "b7/14/1f"
put_template 2  "45/7b/24"
put_template 3  "f6/98/1e"
put_template 4  "13/4e/b2"
put_template 5  "56/00/88"
put_template 6  "0e/71/7c"
put_template 7  "ef/ef/ef"
put_template 8  "42/42/42"
put_template 9  "e8/3b/3f"
put_template 10 "7a/ba/3a"
put_template 11 "ff/ea/2e"
put_template 12 "54/a4/f3"
put_template 13 "aa/4d/bc"
put_template 14 "26/bb/d1"
put_template 15 "d9/d9/d9"

color_foreground="23/23/22"
color_background="ea/ea/ea"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "232322"
  put_template_custom Ph "eaeaea"
  put_template_custom Pi "b7141f"
  put_template_custom Pj "c2c2c2"
  put_template_custom Pk "4e4e4e"
  put_template_custom Pl "16afca"
  put_template_custom Pm "2e2e2d"
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
