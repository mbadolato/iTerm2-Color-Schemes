#!/bin/sh
# GruvboxLightHard

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
put_template 0  "f9/f5/d7"
put_template 1  "cc/24/1d"
put_template 2  "98/97/1a"
put_template 3  "d7/99/21"
put_template 4  "45/85/88"
put_template 5  "b1/62/86"
put_template 6  "68/9d/6a"
put_template 7  "7c/6f/64"
put_template 8  "92/83/74"
put_template 9  "9d/00/06"
put_template 10 "79/74/0e"
put_template 11 "b5/76/14"
put_template 12 "07/66/78"
put_template 13 "8f/3f/71"
put_template 14 "42/7b/58"
put_template 15 "3c/38/36"

color_foreground="3c/38/36"
color_background="f9/f5/d7"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3c3836"
  put_template_custom Ph "f9f5d7"
  put_template_custom Pi "3c3836"
  put_template_custom Pj "3c3836"
  put_template_custom Pk "f9f5d7"
  put_template_custom Pl "3c3836"
  put_template_custom Pm "3c3836"
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
