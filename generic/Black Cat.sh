#!/bin/sh
# Black Cat

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
put_template 0  "a9/a0/b6"
put_template 1  "ff/89/92"
put_template 2  "9f/da/65"
put_template 3  "ed/c8/5e"
put_template 4  "8b/bd/f0"
put_template 5  "c7/8b/f0"
put_template 6  "76/d2/d1"
put_template 7  "f5/ed/ff"
put_template 8  "b3/ab/bf"
put_template 9  "ff/97/9f"
put_template 10 "ab/de/77"
put_template 11 "ef/cf/71"
put_template 12 "99/c5/f2"
put_template 13 "ce/99/f2"
put_template 14 "86/d7/d7"
put_template 15 "f6/ef/ff"

color_foreground="f5/ed/ff"
color_background="18/0a/2b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5edff"
  put_template_custom Ph "180a2b"
  put_template_custom Pi "efcf71"
  put_template_custom Pj "b3abbf"
  put_template_custom Pk "f6efff"
  put_template_custom Pl "ff979f"
  put_template_custom Pm "180a2b"
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
