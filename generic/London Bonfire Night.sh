#!/bin/sh
# London Bonfire Night

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
put_template 0  "1a/14/18"
put_template 1  "d6/5a/3a"
put_template 2  "6a/8a/4a"
put_template 3  "e8/b0/48"
put_template 4  "5a/7a/b8"
put_template 5  "d7/6a/a8"
put_template 6  "88/a8/c8"
put_template 7  "e8/e0/c8"
put_template 8  "44/40/3c"
put_template 9  "ec/76/54"
put_template 10 "88/a8/68"
put_template 11 "f5/c2/5c"
put_template 12 "7a/96/d0"
put_template 13 "ed/85/bc"
put_template 14 "a0/bc/d6"
put_template 15 "fd/f6/df"

color_foreground="e8/e0/c8"
color_background="0e/0c/0e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8e0c8"
  put_template_custom Ph "0e0c0e"
  put_template_custom Pi "e8e0c8"
  put_template_custom Pj "2a2228"
  put_template_custom Pk "e8e0c8"
  put_template_custom Pl "e85aa8"
  put_template_custom Pm "0e0c0e"
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
