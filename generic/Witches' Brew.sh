#!/bin/sh
# Witches' Brew

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
put_template 0  "ae/c2/b4"
put_template 1  "f1/9a/72"
put_template 2  "9b/e8/6b"
put_template 3  "f0/cc/58"
put_template 4  "86/c8/e3"
put_template 5  "d9/9e/d4"
put_template 6  "7a/d9/ce"
put_template 7  "ef/ff/dc"
put_template 8  "c3/d2/c8"
put_template 9  "f6/ae/8c"
put_template 10 "b3/ef/88"
put_template 11 "f6/dc/7b"
put_template 12 "a4/d7/eb"
put_template 13 "e5/b7/df"
put_template 14 "9a/e5/dc"
put_template 15 "fb/ff/f3"

color_foreground="ef/ff/dc"
color_background="07/3b/25"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "efffdc"
  put_template_custom Ph "073b25"
  put_template_custom Pi "a9f05f"
  put_template_custom Pj "245c42"
  put_template_custom Pk "fbfff3"
  put_template_custom Pl "9cf04d"
  put_template_custom Pm "073b25"
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
