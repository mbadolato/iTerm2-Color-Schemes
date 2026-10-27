#!/bin/sh
# Lumina Harbor Light

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
put_template 0  "1c/2d/4f"
put_template 1  "8c/1c/1d"
put_template 2  "19/78/4d"
put_template 3  "a2/5f/06"
put_template 4  "04/68/a4"
put_template 5  "8b/49/9a"
put_template 6  "04/68/71"
put_template 7  "5b/70/97"
put_template 8  "5d/6b/7e"
put_template 9  "65/1f/1d"
put_template 10 "00/62/3c"
put_template 11 "87/4e/00"
put_template 12 "00/54/86"
put_template 13 "71/3b/7d"
put_template 14 "00/53/5a"
put_template 15 "7a/8f/b8"

color_foreground="1c/2d/4f"
color_background="fb/f5/ec"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1c2d4f"
  put_template_custom Ph "fbf5ec"
  put_template_custom Pi "1c2d4f"
  put_template_custom Pj "e3bcce"
  put_template_custom Pk "1c2d4f"
  put_template_custom Pl "1c2d4f"
  put_template_custom Pm "fbf5ec"
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
