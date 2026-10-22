#!/bin/sh
# Lumina Oxblood Dark

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
put_template 0  "29/1b/20"
put_template 1  "de/69/61"
put_template 2  "7d/c7/97"
put_template 3  "f9/c8/75"
put_template 4  "96/c3/fb"
put_template 5  "dd/b7/ed"
put_template 6  "00/be/d0"
put_template 7  "c3/b2/b7"
put_template 8  "a2/85/8f"
put_template 9  "e9/8e/86"
put_template 10 "98/e1/b1"
put_template 11 "ff/e4/b8"
put_template 12 "c0/dc/ff"
put_template 13 "f2/d5/ff"
put_template 14 "76/d2/df"
put_template 15 "e4/d2/d7"

color_foreground="e4/d2/d7"
color_background="23/17/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e4d2d7"
  put_template_custom Ph "23171b"
  put_template_custom Pi "e4d2d7"
  put_template_custom Pj "553441"
  put_template_custom Pk "e4d2d7"
  put_template_custom Pl "e4d2d7"
  put_template_custom Pm "23171b"
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
