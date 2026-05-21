#!/bin/sh
# London Columbia Road

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
put_template 0  "2a/25/20"
put_template 1  "c1/4a/4a"
put_template 2  "5a/8a/3a"
put_template 3  "d4/a8/2c"
put_template 4  "3a/7a/8a"
put_template 5  "c4/5f/8a"
put_template 6  "5f/a8/9a"
put_template 7  "1f/3a/2f"
put_template 8  "75/6a/55"
put_template 9  "d9/6a/6a"
put_template 10 "6e/a0/50"
put_template 11 "d8/af/33"
put_template 12 "55/98/ab"
put_template 13 "d9/7a/a3"
put_template 14 "7a/c0/b0"
put_template 15 "14/22/17"

color_foreground="1f/3a/2f"
color_background="f8/f5/ec"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1f3a2f"
  put_template_custom Ph "f8f5ec"
  put_template_custom Pi "1f3a2f"
  put_template_custom Pj "ece5d0"
  put_template_custom Pk "1f3a2f"
  put_template_custom Pl "d4708e"
  put_template_custom Pm "f8f5ec"
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
