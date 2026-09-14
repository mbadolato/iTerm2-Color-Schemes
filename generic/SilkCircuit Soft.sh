#!/bin/sh
# SilkCircuit Soft

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
put_template 0  "14/12/20"
put_template 1  "ff/66/77"
put_template 2  "66/ff/99"
put_template 3  "ff/e6/99"
put_template 4  "92/aa/ff"
put_template 5  "ff/99/ff"
put_template 6  "99/ff/ee"
put_template 7  "f8/f8/f2"
put_template 8  "62/72/a4"
put_template 9  "ff/77/88"
put_template 10 "80/ff/b3"
put_template 11 "ff/ff/a5"
put_template 12 "a2/bb/ff"
put_template 13 "ff/b3/ff"
put_template 14 "b3/ff/ea"
put_template 15 "ff/ff/ff"

color_foreground="f8/f8/f2"
color_background="1a/16/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8f8f2"
  put_template_custom Ph "1a1626"
  put_template_custom Pi "f8f8f2"
  put_template_custom Pj "44475a"
  put_template_custom Pk "f8f8f2"
  put_template_custom Pl "99ffee"
  put_template_custom Pm "1a1626"
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
