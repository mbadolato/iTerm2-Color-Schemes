#!/bin/sh
# CobaltNext-Minimal

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
put_template 0  "32/3d/47"
put_template 1  "ff/65/7a"
put_template 2  "8c/c9/8f"
put_template 3  "ff/c6/4c"
put_template 4  "40/9d/d4"
put_template 5  "cb/a3/c7"
put_template 6  "37/b5/b4"
put_template 7  "d7/de/ea"
put_template 8  "62/74/7f"
put_template 9  "e4/7e/8b"
put_template 10 "ba/dd/bb"
put_template 11 "ff/dc/91"
put_template 12 "7a/c0/eb"
put_template 13 "f3/cc/ef"
put_template 14 "84/e4/e3"
put_template 15 "ff/ff/ff"

color_foreground="d7/de/ea"
color_background="0b/1c/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d7deea"
  put_template_custom Ph "0b1c24"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "37b5b4"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "37b5b4"
  put_template_custom Pm "ffffff"
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
