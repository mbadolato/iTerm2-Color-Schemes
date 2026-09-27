#!/bin/sh
# Golden Retriever Red

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
put_template 0  "8b/3a/1b"
put_template 1  "d3/54/2c"
put_template 2  "7a/9b/45"
put_template 3  "d9/a4/41"
put_template 4  "46/8b/d6"
put_template 5  "b0/5c/c7"
put_template 6  "4d/b7/a0"
put_template 7  "e0/6b/8f"
put_template 8  "8c/5a/3c"
put_template 9  "e6/73/56"
put_template 10 "9b/ba/5d"
put_template 11 "d6/ad/45"
put_template 12 "65/b8/e8"
put_template 13 "c8/89/e0"
put_template 14 "57/c8/b4"
put_template 15 "f4/a7/c3"

color_foreground="6b/3d/2a"
color_background="ff/f0/e3"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "6b3d2a"
  put_template_custom Ph "fff0e3"
  put_template_custom Pi "a0522d"
  put_template_custom Pj "d28b6c"
  put_template_custom Pk "7d4c38"
  put_template_custom Pl "c97b2e"
  put_template_custom Pm "6b3d2a"
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
