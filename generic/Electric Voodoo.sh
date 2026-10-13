#!/bin/sh
# Electric Voodoo

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
put_template 0  "a8/b2/b8"
put_template 1  "f0/8b/76"
put_template 2  "a9/ca/89"
put_template 3  "ed/c0/77"
put_template 4  "92/ba/e0"
put_template 5  "d9/9f/e4"
put_template 6  "8b/d1/c9"
put_template 7  "fa/e6/ce"
put_template 8  "b9/c1/c6"
put_template 9  "f2/99/86"
put_template 10 "b3/d0/97"
put_template 11 "ef/c8/87"
put_template 12 "9f/c2/e4"
put_template 13 "de/ab/e7"
put_template 14 "99/d7/cf"
put_template 15 "fb/eb/d8"

color_foreground="fa/e6/ce"
color_background="40/21/3c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fae6ce"
  put_template_custom Ph "40213c"
  put_template_custom Pi "fbebd8"
  put_template_custom Pj "603d56"
  put_template_custom Pk "fae6ce"
  put_template_custom Pl "efc887"
  put_template_custom Pm "40213c"
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
