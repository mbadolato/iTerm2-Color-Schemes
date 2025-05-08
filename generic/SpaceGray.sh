#!/bin/sh
# SpaceGray

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
put_template 0  "00/00/00"
put_template 1  "b0/4b/57"
put_template 2  "87/b3/79"
put_template 3  "e5/c1/79"
put_template 4  "7d/8f/a4"
put_template 5  "a4/79/96"
put_template 6  "85/a7/a5"
put_template 7  "b3/b8/c3"
put_template 8  "00/00/00"
put_template 9  "b0/4b/57"
put_template 10 "87/b3/79"
put_template 11 "e5/c1/79"
put_template 12 "7d/8f/a4"
put_template 13 "a4/79/96"
put_template 14 "85/a7/a5"
put_template 15 "ff/ff/ff"

color_foreground="b3/b8/c3"
color_background="20/24/2d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b3b8c3"
  put_template_custom Ph "20242d"
  put_template_custom Pi "b3b8c3"
  put_template_custom Pj "16181e"
  put_template_custom Pk "b3b8c3"
  put_template_custom Pl "b3b8c3"
  put_template_custom Pm "1d1f21"
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
