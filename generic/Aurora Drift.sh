#!/bin/sh
# Aurora Drift

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
put_template 0  "aa/b7/c8"
put_template 1  "ff/6b/6b"
put_template 2  "5f/d9/ad"
put_template 3  "ff/d1/66"
put_template 4  "6e/a8/ff"
put_template 5  "c5/8c/ff"
put_template 6  "54/dd/eb"
put_template 7  "e6/f1/ff"
put_template 8  "c0/ca/d6"
put_template 9  "ff/8b/8b"
put_template 10 "80/e5/bd"
put_template 11 "ff/e2/8a"
put_template 12 "91/bd/ff"
put_template 13 "d9/ad/ff"
put_template 14 "7b/e9/f2"
put_template 15 "ff/ff/ff"

color_foreground="e6/f1/ff"
color_background="05/08/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6f1ff"
  put_template_custom Ph "050814"
  put_template_custom Pi "7aa2ff"
  put_template_custom Pj "263449"
  put_template_custom Pk "f7fbff"
  put_template_custom Pl "00e5ff"
  put_template_custom Pm "050814"
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
