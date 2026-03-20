#!/bin/sh
# Karasu Snow

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
put_template 0  "0a/0a/0a"
put_template 1  "b8/47/55"
put_template 2  "3f/7e/4a"
put_template 3  "8a/6a/1f"
put_template 4  "2e/5e/9b"
put_template 5  "6c/4b/b8"
put_template 6  "2d/7e/7a"
put_template 7  "b5/b5/b5"
put_template 8  "40/40/40"
put_template 9  "d9/3c/3c"
put_template 10 "2f/91/50"
put_template 11 "9a/7a/1d"
put_template 12 "2b/72/c7"
put_template 13 "7b/59/d6"
put_template 14 "1f/96/8f"
put_template 15 "ff/ff/ff"

color_foreground="29/25/24"
color_background="fa/fa/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "292524"
  put_template_custom Ph "fafafa"
  put_template_custom Pi "292524"
  put_template_custom Pj "e5e5e5"
  put_template_custom Pk "292524"
  put_template_custom Pl "0a0a0a"
  put_template_custom Pm "fafafa"
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
