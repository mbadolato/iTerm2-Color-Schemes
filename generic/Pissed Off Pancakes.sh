#!/bin/sh
# Pissed Off Pancakes

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
put_template 0  "aa/a5/9c"
put_template 1  "db/53/3e"
put_template 2  "7c/b8/5b"
put_template 3  "e4/b3/3f"
put_template 4  "4a/a3/ff"
put_template 5  "b3/5c/ff"
put_template 6  "33/d6/c9"
put_template 7  "f8/ed/d7"
put_template 8  "c6/c0/b5"
put_template 9  "ff/6b/4d"
put_template 10 "a4/dc/79"
put_template 11 "f7/d8/67"
put_template 12 "73/b9/ff"
put_template 13 "cd/8a/ff"
put_template 14 "62/e5/d9"
put_template 15 "ff/f4/d2"

color_foreground="f8/ed/d7"
color_background="1a/12/08"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8edd7"
  put_template_custom Ph "1a1208"
  put_template_custom Pi "f4d35e"
  put_template_custom Pj "5a3b1a"
  put_template_custom Pk "fff7e8"
  put_template_custom Pl "f4d35e"
  put_template_custom Pm "1a1208"
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
