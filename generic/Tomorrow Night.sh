#!/bin/sh
# Tomorrow Night

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
put_template 1  "cc/66/66"
put_template 2  "b5/bd/68"
put_template 3  "f0/c6/74"
put_template 4  "81/a2/be"
put_template 5  "b2/94/bb"
put_template 6  "8a/be/b7"
put_template 7  "ff/ff/ff"
put_template 8  "00/00/00"
put_template 9  "cc/66/66"
put_template 10 "b5/bd/68"
put_template 11 "f0/c6/74"
put_template 12 "81/a2/be"
put_template 13 "b2/94/bb"
put_template 14 "8a/be/b7"
put_template 15 "ff/ff/ff"

color_foreground="c5/c8/c6"
color_background="1d/1f/21"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c5c8c6"
  put_template_custom Ph "1d1f21"
  put_template_custom Pi "c5c8c6"
  put_template_custom Pj "373b41"
  put_template_custom Pk "c5c8c6"
  put_template_custom Pl "c5c8c6"
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
