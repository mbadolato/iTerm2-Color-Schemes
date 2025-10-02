#!/bin/sh
# Tearout

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
put_template 0  "68/57/42"
put_template 1  "cc/96/7b"
put_template 2  "97/97/6d"
put_template 3  "6c/98/61"
put_template 4  "b5/95/5e"
put_template 5  "c9/a5/54"
put_template 6  "d7/c4/83"
put_template 7  "b5/95/5e"
put_template 8  "75/64/4f"
put_template 9  "cc/96/7b"
put_template 10 "97/97/6d"
put_template 11 "6c/98/61"
put_template 12 "b5/95/5e"
put_template 13 "c9/a5/54"
put_template 14 "d7/c4/83"
put_template 15 "b5/95/5e"

color_foreground="f4/d2/ae"
color_background="34/39/2d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f4d2ae"
  put_template_custom Ph "34392d"
  put_template_custom Pi "f4d2ae"
  put_template_custom Pj "e4c47a"
  put_template_custom Pk "000000"
  put_template_custom Pl "d7c483"
  put_template_custom Pm "141415"
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
