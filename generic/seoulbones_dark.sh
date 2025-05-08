#!/bin/sh
# seoulbones_dark

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
put_template 0  "4b/4b/4b"
put_template 1  "e3/88/a3"
put_template 2  "98/bd/99"
put_template 3  "ff/df/9b"
put_template 4  "97/bd/de"
put_template 5  "a5/a6/c5"
put_template 6  "6f/bd/be"
put_template 7  "dd/dd/dd"
put_template 8  "6c/64/65"
put_template 9  "eb/99/b1"
put_template 10 "8f/cd/92"
put_template 11 "ff/e5/b3"
put_template 12 "a2/c8/e9"
put_template 13 "b2/b3/da"
put_template 14 "6b/ca/cb"
put_template 15 "a8/a8/a8"

color_foreground="dd/dd/dd"
color_background="4b/4b/4b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dddddd"
  put_template_custom Ph "4b4b4b"
  put_template_custom Pi "6c6465"
  put_template_custom Pj "777777"
  put_template_custom Pk "dddddd"
  put_template_custom Pl "e2e2e2"
  put_template_custom Pm "4b4b4b"
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
