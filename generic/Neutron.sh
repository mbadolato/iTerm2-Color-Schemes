#!/bin/sh
# Neutron

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
put_template 0  "23/25/2b"
put_template 1  "b5/40/36"
put_template 2  "5a/b9/77"
put_template 3  "de/b5/66"
put_template 4  "6a/7c/93"
put_template 5  "a4/79/9d"
put_template 6  "3f/94/a8"
put_template 7  "e6/e8/ef"
put_template 8  "23/25/2b"
put_template 9  "b5/40/36"
put_template 10 "5a/b9/77"
put_template 11 "de/b5/66"
put_template 12 "6a/7c/93"
put_template 13 "a4/79/9d"
put_template 14 "3f/94/a8"
put_template 15 "eb/ed/f2"

color_foreground="e6/e8/ef"
color_background="1c/1e/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e8ef"
  put_template_custom Ph "1c1e22"
  put_template_custom Pi "52606b"
  put_template_custom Pj "2f363e"
  put_template_custom Pk "7d8fa4"
  put_template_custom Pl "f6f7ec"
  put_template_custom Pm "c4c5b5"
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
