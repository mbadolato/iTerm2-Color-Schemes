#!/bin/sh
# This One Goes to 11

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
put_template 0  "29/27/22"
put_template 1  "d9/6a/58"
put_template 2  "89/b6/7c"
put_template 3  "d6/aa/4a"
put_template 4  "82/a8/c8"
put_template 5  "b4/9a/c7"
put_template 6  "78/b8/b0"
put_template 7  "d9/cf/b9"
put_template 8  "82/7b/6d"
put_template 9  "ff/95/80"
put_template 10 "b8/e3/a5"
put_template 11 "ff/d3/6b"
put_template 12 "b4/d7/f2"
put_template 13 "df/c0/ef"
put_template 14 "a6/e7/de"
put_template 15 "ff/f5/df"

color_foreground="f0/e6/ce"
color_background="10/10/0f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f0e6ce"
  put_template_custom Ph "10100f"
  put_template_custom Pi "fff4d8"
  put_template_custom Pj "55431f"
  put_template_custom Pk "fff6e5"
  put_template_custom Pl "e6b74e"
  put_template_custom Pm "10100f"
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
