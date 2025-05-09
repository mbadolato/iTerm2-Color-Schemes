#!/bin/sh
# Monokai Pro Octagon

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
put_template 0  "28/2a/3a"
put_template 1  "ff/65/7a"
put_template 2  "ba/d7/61"
put_template 3  "ff/d7/6d"
put_template 4  "ff/9b/5e"
put_template 5  "c3/9a/c9"
put_template 6  "9c/d1/bb"
put_template 7  "ea/f2/f1"
put_template 8  "69/6d/77"
put_template 9  "ff/65/7a"
put_template 10 "ba/d7/61"
put_template 11 "ff/d7/6d"
put_template 12 "ff/9b/5e"
put_template 13 "c3/9a/c9"
put_template 14 "9c/d1/bb"
put_template 15 "ea/f2/f1"

color_foreground="ea/f2/f1"
color_background="28/2a/3a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eaf2f1"
  put_template_custom Ph "282a3a"
  put_template_custom Pi "9cd1bb"
  put_template_custom Pj "535763"
  put_template_custom Pk "eaf2f1"
  put_template_custom Pl "b2b9bd"
  put_template_custom Pm "b2b9bd"
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
