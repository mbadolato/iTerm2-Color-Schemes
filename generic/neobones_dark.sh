#!/bin/sh
# neobones_dark

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
put_template 0  "0f/19/1f"
put_template 1  "de/6e/7c"
put_template 2  "90/ff/6b"
put_template 3  "b7/7e/64"
put_template 4  "81/90/d4"
put_template 5  "b2/79/a7"
put_template 6  "66/a5/ad"
put_template 7  "c6/d5/cf"
put_template 8  "26/39/45"
put_template 9  "e8/83/8f"
put_template 10 "a0/ff/85"
put_template 11 "d6/8c/67"
put_template 12 "92/a0/e2"
put_template 13 "cf/86/c1"
put_template 14 "65/b8/c1"
put_template 15 "98/a3/9e"

color_foreground="c6/d5/cf"
color_background="0f/19/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c6d5cf"
  put_template_custom Ph "0f191f"
  put_template_custom Pi "263945"
  put_template_custom Pj "3a3e3d"
  put_template_custom Pk "c6d5cf"
  put_template_custom Pl "ceddd7"
  put_template_custom Pm "0f191f"
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
