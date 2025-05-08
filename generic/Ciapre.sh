#!/bin/sh
# Ciapre

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
put_template 0  "18/18/18"
put_template 1  "81/00/09"
put_template 2  "48/51/3b"
put_template 3  "cc/8b/3f"
put_template 4  "57/6d/8c"
put_template 5  "72/4d/7c"
put_template 6  "5c/4f/4b"
put_template 7  "ae/a4/7f"
put_template 8  "55/55/55"
put_template 9  "ac/38/35"
put_template 10 "a6/a7/5d"
put_template 11 "dc/df/7c"
put_template 12 "30/97/c6"
put_template 13 "d3/30/61"
put_template 14 "f3/db/b2"
put_template 15 "f4/f4/f4"

color_foreground="ae/a4/7a"
color_background="19/1c/27"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "aea47a"
  put_template_custom Ph "191c27"
  put_template_custom Pi "f4f4f4"
  put_template_custom Pj "172539"
  put_template_custom Pk "aea47f"
  put_template_custom Pl "92805b"
  put_template_custom Pm "181818"
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
