#!/bin/sh
# Earl Grey

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
put_template 0  "60/5a/52"
put_template 1  "8f/56/52"
put_template 2  "74/7b/4d"
put_template 3  "89/7d/43"
put_template 4  "55/69/95"
put_template 5  "83/57/7d"
put_template 6  "47/7a/7b"
put_template 7  "c2/be/b8"
put_template 8  "a8/a0/94"
put_template 9  "82/40/3c"
put_template 10 "65/6d/37"
put_template 11 "79/6d/2f"
put_template 12 "3e/55/88"
put_template 13 "77/40/6f"
put_template 14 "32/6b/6c"
put_template 15 "c2/be/b8"

color_foreground="60/5a/52"
color_background="fc/fb/f9"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "605a52"
  put_template_custom Ph "fcfbf9"
  put_template_custom Pi "605a52"
  put_template_custom Pj "e1ddd6"
  put_template_custom Pk "605a52"
  put_template_custom Pl "605a52"
  put_template_custom Pm "fcfbf9"
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
