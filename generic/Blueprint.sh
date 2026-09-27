#!/bin/sh
# Blueprint

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
put_template 0  "0f/17/2a"
put_template 1  "dc/26/26"
put_template 2  "16/a3/4a"
put_template 3  "d9/77/06"
put_template 4  "25/63/eb"
put_template 5  "7c/3a/ed"
put_template 6  "08/91/b2"
put_template 7  "94/a3/b8"
put_template 8  "47/55/69"
put_template 9  "ef/44/44"
put_template 10 "22/c5/5e"
put_template 11 "f5/9e/0b"
put_template 12 "3b/82/f6"
put_template 13 "a8/55/f7"
put_template 14 "06/b6/d4"
put_template 15 "1e/29/3b"

color_foreground="0f/17/2a"
color_background="f8/fa/fc"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "0f172a"
  put_template_custom Ph "f8fafc"
  put_template_custom Pi "e2e8f0"
  put_template_custom Pj "cbd5e1"
  put_template_custom Pk "0f172a"
  put_template_custom Pl "ff5a1f"
  put_template_custom Pm "f1f5f9"
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
