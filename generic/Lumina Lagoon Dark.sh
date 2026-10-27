#!/bin/sh
# Lumina Lagoon Dark

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
put_template 0  "04/2e/36"
put_template 1  "d3/72/6a"
put_template 2  "9f/d4/a9"
put_template 3  "e7/cf/94"
put_template 4  "8e/c3/f9"
put_template 5  "e5/b0/df"
put_template 6  "5a/d3/d6"
put_template 7  "b7/c5/c6"
put_template 8  "7d/9b/a2"
put_template 9  "e0/93/8c"
put_template 10 "b8/ef/c2"
put_template 11 "ff/e6/a7"
put_template 12 "ba/dc/ff"
put_template 13 "ff/ca/f9"
put_template 14 "9f/e6/e8"
put_template 15 "d7/e6/e7"

color_foreground="d7/e6/e7"
color_background="04/29/30"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d7e6e7"
  put_template_custom Ph "042930"
  put_template_custom Pi "d7e6e7"
  put_template_custom Pj "0e535a"
  put_template_custom Pk "d7e6e7"
  put_template_custom Pl "d7e6e7"
  put_template_custom Pm "042930"
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
