#!/bin/sh
# Graveyard Shift

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
put_template 0  "c0/cb/c5"
put_template 1  "ed/9b/86"
put_template 2  "9f/c7/9a"
put_template 3  "df/c9/77"
put_template 4  "91/bc/c8"
put_template 5  "b6/a5/c0"
put_template 6  "87/c7/c2"
put_template 7  "ee/f2/e8"
put_template 8  "c8/d1/cc"
put_template 9  "ef/a7/95"
put_template 10 "ab/ce/a6"
put_template 11 "e3/cf/87"
put_template 12 "9e/c4/cf"
put_template 13 "bf/b0/c8"
put_template 14 "95/ce/c9"
put_template 15 "f0/f4/eb"

color_foreground="ee/f2/e8"
color_background="2e/42/40"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eef2e8"
  put_template_custom Ph "2e4240"
  put_template_custom Pi "e3cf87"
  put_template_custom Pj "c8d1cc"
  put_template_custom Pk "979b92"
  put_template_custom Pl "efa795"
  put_template_custom Pm "2e4240"
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
