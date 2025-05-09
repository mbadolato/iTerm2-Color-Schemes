#!/bin/sh
# Monokai Pro Ristretto

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
put_template 0  "2c/25/25"
put_template 1  "fd/68/83"
put_template 2  "ad/da/78"
put_template 3  "f9/cc/6c"
put_template 4  "f3/8d/70"
put_template 5  "a8/a9/eb"
put_template 6  "85/da/cc"
put_template 7  "ff/f1/f3"
put_template 8  "72/69/6a"
put_template 9  "fd/68/83"
put_template 10 "ad/da/78"
put_template 11 "f9/cc/6c"
put_template 12 "f3/8d/70"
put_template 13 "a8/a9/eb"
put_template 14 "85/da/cc"
put_template 15 "ff/f1/f3"

color_foreground="ff/f1/f3"
color_background="2c/25/25"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff1f3"
  put_template_custom Ph "2c2525"
  put_template_custom Pi "85dacc"
  put_template_custom Pj "5b5353"
  put_template_custom Pk "fff1f3"
  put_template_custom Pl "c3b7b8"
  put_template_custom Pm "c3b7b8"
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
