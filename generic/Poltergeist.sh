#!/bin/sh
# Poltergeist

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
put_template 0  "c0/d1/d2"
put_template 1  "ff/9c/91"
put_template 2  "8c/e0/b0"
put_template 3  "e9/d0/6c"
put_template 4  "8e/d4/ed"
put_template 5  "c5/a7/e8"
put_template 6  "77/e1/df"
put_template 7  "f0/ff/ff"
put_template 8  "c8/d7/d7"
put_template 9  "ff/a8/9e"
put_template 10 "9a/e4/b9"
put_template 11 "ec/d6/7e"
put_template 12 "9c/d9/ef"
put_template 13 "cc/b2/eb"
put_template 14 "87/e5/e3"
put_template 15 "f2/ff/ff"

color_foreground="f0/ff/ff"
color_background="06/44/4b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f0ffff"
  put_template_custom Ph "06444b"
  put_template_custom Pi "ecd67e"
  put_template_custom Pj "c8d7d7"
  put_template_custom Pk "8c9999"
  put_template_custom Pl "ffa89e"
  put_template_custom Pm "06444b"
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
