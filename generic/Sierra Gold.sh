#!/bin/sh
# Sierra Gold

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
put_template 0  "cb/b4/9b"
put_template 1  "f4/a1/7c"
put_template 2  "a8/c9/8b"
put_template 3  "f3/c8/73"
put_template 4  "9d/c5/ed"
put_template 5  "d6/a5/d8"
put_template 6  "92/d4/d4"
put_template 7  "f9/e6/c7"
put_template 8  "e0/cd/b5"
put_template 9  "ff/c2/9d"
put_template 10 "c3/dc/a3"
put_template 11 "ff/db/91"
put_template 12 "b9/d9/fa"
put_template 13 "e7/bd/e9"
put_template 14 "af/e6/e2"
put_template 15 "ff/f5/df"

color_foreground="f9/e6/c7"
color_background="39/24/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f9e6c7"
  put_template_custom Ph "392414"
  put_template_custom Pi "ffdb91"
  put_template_custom Pj "8e684a"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "ffdb91"
  put_template_custom Pm "392414"
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
