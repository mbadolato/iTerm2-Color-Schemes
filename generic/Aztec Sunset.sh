#!/bin/sh
# Aztec Sunset

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
put_template 0  "a9/a1/9f"
put_template 1  "f4/7c/62"
put_template 2  "67/c8/94"
put_template 3  "e9/bd/59"
put_template 4  "72/c6/c2"
put_template 5  "e7/78/a8"
put_template 6  "65/d5/d0"
put_template 7  "ff/e6/c7"
put_template 8  "c0/b4/b0"
put_template 9  "ff/98/6d"
put_template 10 "86/d7/a8"
put_template 11 "ff/d0/71"
put_template 12 "8b/d8/d2"
put_template 13 "f1/94/bd"
put_template 14 "89/e2/dc"
put_template 15 "ff/f4/df"

color_foreground="ff/e6/c7"
color_background="1b/0c/18"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffe6c7"
  put_template_custom Ph "1b0c18"
  put_template_custom Pi "ff9638"
  put_template_custom Pj "743829"
  put_template_custom Pk "fff0d8"
  put_template_custom Pl "ff9f2e"
  put_template_custom Pm "1b0c18"
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
