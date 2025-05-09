#!/bin/sh
# darkmatrix

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
put_template 0  "09/10/13"
put_template 1  "00/65/36"
put_template 2  "6f/a6/4c"
put_template 3  "7e/80/00"
put_template 4  "2c/9a/84"
put_template 5  "45/2d/53"
put_template 6  "11/4d/53"
put_template 7  "00/65/36"
put_template 8  "33/33/33"
put_template 9  "00/73/3d"
put_template 10 "90/d7/62"
put_template 11 "e2/e5/00"
put_template 12 "46/d8/b8"
put_template 13 "4a/30/59"
put_template 14 "12/54/5a"
put_template 15 "00/65/36"

color_foreground="3e/57/15"
color_background="07/0c/0e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3e5715"
  put_template_custom Ph "070c0e"
  put_template_custom Pi "00cd6d"
  put_template_custom Pj "0f191c"
  put_template_custom Pk "00ff87"
  put_template_custom Pl "9fa86e"
  put_template_custom Pm "00ff87"
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
