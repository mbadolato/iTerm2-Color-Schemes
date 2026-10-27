#!/bin/sh
# Bauhaus Dark

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
put_template 0  "57/4d/43"
put_template 1  "ff/3e/42"
put_template 2  "79/93/2d"
put_template 3  "b1/82/01"
put_template 4  "66/89/cf"
put_template 5  "c6/61/cf"
put_template 6  "09/99/97"
put_template 7  "9a/9a/9a"
put_template 8  "9a/9a/9a"
put_template 9  "ff/8d/84"
put_template 10 "9c/b8/55"
put_template 11 "de/a3/01"
put_template 12 "88/ad/f6"
put_template 13 "ed/86/f6"
put_template 14 "38/bf/bc"
put_template 15 "f2/f2/f2"

color_foreground="f2/f2/f2"
color_background="2b/21/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2f2f2"
  put_template_custom Ph "2b2119"
  put_template_custom Pi "f2f2f2"
  put_template_custom Pj "2e354a"
  put_template_custom Pk "f2f2f2"
  put_template_custom Pl "f60529"
  put_template_custom Pm "2b2119"
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
