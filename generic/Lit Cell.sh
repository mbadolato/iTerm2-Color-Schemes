#!/bin/sh
# Lit Cell

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
put_template 0  "1c/24/20"
put_template 1  "ff/6b/6b"
put_template 2  "3d/f2/a0"
put_template 3  "ff/b0/00"
put_template 4  "6f/b3/f2"
put_template 5  "c9/9a/f2"
put_template 6  "48/d6/cf"
put_template 7  "b9/c7/be"
put_template 8  "75/86/79"
put_template 9  "ff/94/94"
put_template 10 "86/ff/c6"
put_template 11 "ff/cb/5c"
put_template 12 "9c/cb/ff"
put_template 13 "dd/bc/ff"
put_template 14 "86/ec/e6"
put_template 15 "ed/ef/ea"

color_foreground="cf/dd/d3"
color_background="0c/11/0e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cfddd3"
  put_template_custom Ph "0c110e"
  put_template_custom Pi "cfddd3"
  put_template_custom Pj "1e4533"
  put_template_custom Pk "edefea"
  put_template_custom Pl "3df2a0"
  put_template_custom Pm "0c110e"
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
