#!/bin/sh
# Poimandres White

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
put_template 0  "fe/fe/ff"
put_template 1  "ff/20/90"
put_template 2  "01/da/b2"
put_template 3  "e5/ba/4e"
put_template 4  "8a/ba/cd"
put_template 5  "eb/83/94"
put_template 6  "8a/ba/cd"
put_template 7  "00/00/00"
put_template 8  "96/9c/bd"
put_template 9  "ff/20/90"
put_template 10 "01/da/b2"
put_template 11 "e5/ba/4e"
put_template 12 "0e/bf/ff"
put_template 13 "eb/83/94"
put_template 14 "0e/bf/ff"
put_template 15 "00/00/00"

color_foreground="96/9c/bd"
color_background="fe/fe/ff"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "969cbd"
  put_template_custom Ph "fefeff"
  put_template_custom Pi "969cbd"
  put_template_custom Pj "969cbd"
  put_template_custom Pk "3b3e48"
  put_template_custom Pl "969cbd"
  put_template_custom Pm "fefeff"
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
