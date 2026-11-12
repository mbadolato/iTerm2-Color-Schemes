#!/bin/sh
# Zacess Warm Dark

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
put_template 0  "ad/a3/98"
put_template 1  "fc/9a/8d"
put_template 2  "a2/be/6f"
put_template 3  "e4/b3/5b"
put_template 4  "88/b9/e3"
put_template 5  "df/a1/ca"
put_template 6  "73/c2/b8"
put_template 7  "cb/c1/b1"
put_template 8  "b9/b1/a9"
put_template 9  "fe/e4/e0"
put_template 10 "d9/f2/b0"
put_template 11 "ff/e9/b6"
put_template 12 "d7/ec/ff"
put_template 13 "ff/e1/f4"
put_template 14 "b1/f7/ed"
put_template 15 "fb/f1/dc"

color_foreground="e5/d5/b6"
color_background="21/1b/17"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e5d5b6"
  put_template_custom Ph "211b17"
  put_template_custom Pi "e5d5b6"
  put_template_custom Pj "7abad3"
  put_template_custom Pk "211b17"
  put_template_custom Pl "fec9a7"
  put_template_custom Pm "211b17"
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
