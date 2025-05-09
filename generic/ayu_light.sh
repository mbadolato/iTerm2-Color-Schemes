#!/bin/sh
# ayu_light

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
put_template 1  "ff/33/33"
put_template 2  "86/b3/00"
put_template 3  "f2/97/18"
put_template 4  "41/a6/d9"
put_template 5  "f0/71/78"
put_template 6  "4d/bf/99"
put_template 7  "ff/ff/ff"
put_template 8  "32/32/32"
put_template 9  "ff/65/65"
put_template 10 "b8/e5/32"
put_template 11 "ff/c9/4a"
put_template 12 "73/d8/ff"
put_template 13 "ff/a3/aa"
put_template 14 "7f/f1/cb"
put_template 15 "ff/ff/ff"

color_foreground="5c/67/73"
color_background="fa/fa/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "5c6773"
  put_template_custom Ph "fafafa"
  put_template_custom Pi "5c6773"
  put_template_custom Pj "f0eee4"
  put_template_custom Pk "5c6773"
  put_template_custom Pl "ff6a00"
  put_template_custom Pm "5c6773"
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
