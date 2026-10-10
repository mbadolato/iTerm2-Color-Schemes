#!/bin/sh
# Cursed VHS

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
put_template 0  "af/a3/bd"
put_template 1  "ff/6d/98"
put_template 2  "8e/d6/9e"
put_template 3  "e5/c8/5f"
put_template 4  "62/b9/f2"
put_template 5  "d1/6c/f0"
put_template 6  "4b/d9/e1"
put_template 7  "f4/ed/ff"
put_template 8  "b9/ae/c5"
put_template 9  "ff/7f/a4"
put_template 10 "9c/db/aa"
put_template 11 "e8/cf/72"
put_template 12 "75/c1/f4"
put_template 13 "d7/7e/f2"
put_template 14 "61/de/e5"
put_template 15 "f5/ef/ff"

color_foreground="f4/ed/ff"
color_background="1c/08/2c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f4edff"
  put_template_custom Ph "1c082c"
  put_template_custom Pi "e8cf72"
  put_template_custom Pj "b9aec5"
  put_template_custom Pk "f5efff"
  put_template_custom Pl "ff7fa4"
  put_template_custom Pm "1c082c"
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
