#!/bin/sh
# Prismatica

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
put_template 1  "ef/76/7d"
put_template 2  "87/c7/9c"
put_template 3  "eb/c8/6b"
put_template 4  "84/b5/ed"
put_template 5  "d6/9e/dc"
put_template 6  "79/d2/d2"
put_template 7  "ed/f0/f4"
put_template 8  "b9/c1/c6"
put_template 9  "f1/86/8d"
put_template 10 "95/ce/a8"
put_template 11 "ed/cf/7d"
put_template 12 "93/be/ef"
put_template 13 "db/aa/e0"
put_template 14 "89/d7/d7"
put_template 15 "f1/f3/f6"

color_foreground="ed/f0/f4"
color_background="10/15/1e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "edf0f4"
  put_template_custom Ph "10151e"
  put_template_custom Pi "f1f3f6"
  put_template_custom Pj "3e3541"
  put_template_custom Pk "edf0f4"
  put_template_custom Pl "edcf7d"
  put_template_custom Pm "10151e"
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
