#!/bin/sh
# Sumi Ink

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
put_template 0  "3a/34/2e"
put_template 1  "c0/50/3f"
put_template 2  "7f/9a/6a"
put_template 3  "c9/a4/5c"
put_template 4  "6f/86/a8"
put_template 5  "a6/6b/86"
put_template 6  "6f/a3/9a"
put_template 7  "d8/cc/b4"
put_template 8  "7a/71/66"
put_template 9  "d8/70/5e"
put_template 10 "9c/b5/85"
put_template 11 "dc/bd/7a"
put_template 12 "8e/a2/c0"
put_template 13 "c0/8a/a2"
put_template 14 "8f/bd/b3"
put_template 15 "ef/e5/d1"

color_foreground="e6/dc/c6"
color_background="1e/1b/18"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6dcc6"
  put_template_custom Ph "1e1b18"
  put_template_custom Pi "e6dcc6"
  put_template_custom Pj "a3362a"
  put_template_custom Pk "efe5d1"
  put_template_custom Pl "a3362a"
  put_template_custom Pm "efe5d1"
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
