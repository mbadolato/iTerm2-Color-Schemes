#!/bin/sh
# Forged in Steel

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
put_template 0  "9d/ae/bc"
put_template 1  "db/77/79"
put_template 2  "95/b9/b7"
put_template 3  "bc/b9/a1"
put_template 4  "83/b8/da"
put_template 5  "a8/b2/c9"
put_template 6  "81/c8/d4"
put_template 7  "db/e8/ee"
put_template 8  "b7/c6/d0"
put_template 9  "ef/85/83"
put_template 10 "a9/c9/c4"
put_template 11 "d2/cf/b7"
put_template 12 "a0/cb/ea"
put_template 13 "c0/c8/d9"
put_template 14 "9a/d9/e0"
put_template 15 "ff/ff/ff"

color_foreground="e8/f1/f5"
color_background="14/23/2f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8f1f5"
  put_template_custom Ph "14232f"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "354b5a"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "c8dce8"
  put_template_custom Pm "14232f"
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
