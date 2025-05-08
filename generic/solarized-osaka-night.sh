#!/bin/sh
# solarized-osaka-night

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
put_template 0  "15/16/1d"
put_template 1  "e7/7d/8f"
put_template 2  "a8/cd/76"
put_template 3  "d8/b1/72"
put_template 4  "82/a1/f1"
put_template 5  "b6/9b/f1"
put_template 6  "90/cd/fa"
put_template 7  "aa/b1/d3"
put_template 8  "42/48/66"
put_template 9  "e7/7d/8f"
put_template 10 "a8/cd/76"
put_template 11 "d8/b1/72"
put_template 12 "82/a1/f1"
put_template 13 "b6/9b/f1"
put_template 14 "90/cd/fa"
put_template 15 "c2/ca/f1"

color_foreground="c2/ca/f1"
color_background="1a/1b/25"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c2caf1"
  put_template_custom Ph "1a1b25"
  put_template_custom Pi "58b99d"
  put_template_custom Pj "2a3454"
  put_template_custom Pk "c2caf1"
  put_template_custom Pl "c2caf1"
  put_template_custom Pm "1a1b25"
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
