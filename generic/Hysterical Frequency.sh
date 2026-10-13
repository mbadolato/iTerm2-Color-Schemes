#!/bin/sh
# Hysterical Frequency

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
put_template 1  "e7/7b/9c"
put_template 2  "8d/c8/a0"
put_template 3  "ed/c8/6e"
put_template 4  "82/ba/f0"
put_template 5  "d1/a1/eb"
put_template 6  "7b/d1/db"
put_template 7  "f1/eb/fa"
put_template 8  "b9/c1/c6"
put_template 9  "ea/8b/a8"
put_template 10 "9b/cf/ab"
put_template 11 "ef/cf/7f"
put_template 12 "91/c2/f2"
put_template 13 "d7/ac/ed"
put_template 14 "8b/d7/df"
put_template 15 "f4/ef/fb"

color_foreground="f1/eb/fa"
color_background="20/24/44"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f1ebfa"
  put_template_custom Ph "202444"
  put_template_custom Pi "f4effb"
  put_template_custom Pj "493f5c"
  put_template_custom Pk "f1ebfa"
  put_template_custom Pl "efcf7f"
  put_template_custom Pm "202444"
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
