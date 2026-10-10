#!/bin/sh
# Poison Apple

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
put_template 0  "bc/a8/aa"
put_template 1  "ef/81/78"
put_template 2  "9e/d2/5f"
put_template 3  "e5/c4/5b"
put_template 4  "86/b9/d8"
put_template 5  "c2/8b/b9"
put_template 6  "7c/c4/bc"
put_template 7  "f7/e8/d8"
put_template 8  "c4/b2/b4"
put_template 9  "f1/90/88"
put_template 10 "aa/d7/72"
put_template 11 "e8/cb/6f"
put_template 12 "95/c1/dd"
put_template 13 "c9/99/c1"
put_template 14 "8c/cb/c4"
put_template 15 "f8/eb/dd"

color_foreground="f7/e8/d8"
color_background="56/0b/13"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7e8d8"
  put_template_custom Ph "560b13"
  put_template_custom Pi "e8cb6f"
  put_template_custom Pj "c4b2b4"
  put_template_custom Pk "fff8ea"
  put_template_custom Pl "f19088"
  put_template_custom Pm "560b13"
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
