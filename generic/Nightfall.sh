#!/bin/sh
# Nightfall

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
put_template 0  "3a/2f/24"
put_template 1  "e8/75/55"
put_template 2  "83/b9/6f"
put_template 3  "e8/ad/3f"
put_template 4  "5f/9e/d8"
put_template 5  "bd/6f/ae"
put_template 6  "4d/be/b1"
put_template 7  "d9/c0/9a"
put_template 8  "5b/4a/3a"
put_template 9  "f2/8b/6b"
put_template 10 "a8/d0/7d"
put_template 11 "ff/d1/66"
put_template 12 "79/b5/e8"
put_template 13 "eb/a1/d9"
put_template 14 "66/d0/c4"
put_template 15 "ff/f2/d6"

color_foreground="f6/e8/d0"
color_background="1a/14/0e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f6e8d0"
  put_template_custom Ph "1a140e"
  put_template_custom Pi "d8ad7a"
  put_template_custom Pj "3b2a1a"
  put_template_custom Pk "f6e8d0"
  put_template_custom Pl "d4a85c"
  put_template_custom Pm "1a140e"
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
