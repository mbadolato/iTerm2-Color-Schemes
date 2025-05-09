#!/bin/sh
# OneHalfLight

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
put_template 0  "38/3a/42"
put_template 1  "e4/56/49"
put_template 2  "50/a1/4f"
put_template 3  "c1/84/01"
put_template 4  "01/84/bc"
put_template 5  "a6/26/a4"
put_template 6  "09/97/b3"
put_template 7  "fa/fa/fa"
put_template 8  "4f/52/5e"
put_template 9  "e0/6c/75"
put_template 10 "98/c3/79"
put_template 11 "e5/c0/7b"
put_template 12 "61/af/ef"
put_template 13 "c6/78/dd"
put_template 14 "56/b6/c2"
put_template 15 "ff/ff/ff"

color_foreground="38/3a/42"
color_background="fa/fa/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "383a42"
  put_template_custom Ph "fafafa"
  put_template_custom Pi "abb2bf"
  put_template_custom Pj "bfceff"
  put_template_custom Pk "383a42"
  put_template_custom Pl "bfceff"
  put_template_custom Pm "383a42"
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
