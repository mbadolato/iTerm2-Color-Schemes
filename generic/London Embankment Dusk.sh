#!/bin/sh
# London Embankment Dusk

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
put_template 0  "1c/25/33"
put_template 1  "c5/57/3f"
put_template 2  "6a/8e/85"
put_template 3  "e2/bd/5c"
put_template 4  "5e/87/b3"
put_template 5  "9b/86/a8"
put_template 6  "82/a8/b8"
put_template 7  "e8/ee/f2"
put_template 8  "4a/56/6a"
put_template 9  "e0/70/50"
put_template 10 "88/aa/a3"
put_template 11 "f0/cd/6c"
put_template 12 "82/a4/cc"
put_template 13 "b0/9b/c0"
put_template 14 "a0/c2/d0"
put_template 15 "fa/fb/fc"

color_foreground="e8/ee/f2"
color_background="16/1f/2c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8eef2"
  put_template_custom Ph "161f2c"
  put_template_custom Pi "e8eef2"
  put_template_custom Pj "2c3a52"
  put_template_custom Pk "e8eef2"
  put_template_custom Pl "f2c455"
  put_template_custom Pm "161f2c"
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
