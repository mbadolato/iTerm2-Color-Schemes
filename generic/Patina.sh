#!/bin/sh
# Patina

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
put_template 0  "16/20/1c"
put_template 1  "d9/60/3f"
put_template 2  "9f/c0/8c"
put_template 3  "c8/a2/4a"
put_template 4  "5f/c9/b0"
put_template 5  "d7/b4/5a"
put_template 6  "7f/d0/c0"
put_template 7  "dc/e5/de"
put_template 8  "5c/70/68"
put_template 9  "df/78/5c"
put_template 10 "ab/c8/9a"
put_template 11 "d9/8e/5a"
put_template 12 "5f/c9/b0"
put_template 13 "e0/c3/6a"
put_template 14 "8e/d6/c8"
put_template 15 "ff/ff/ff"

color_foreground="dc/e5/de"
color_background="0e/16/13"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dce5de"
  put_template_custom Ph "0e1613"
  put_template_custom Pi "dce5de"
  put_template_custom Pj "23302b"
  put_template_custom Pk "4e5653"
  put_template_custom Pl "e0c36a"
  put_template_custom Pm "0e1613"
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
