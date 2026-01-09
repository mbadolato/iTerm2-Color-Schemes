#!/bin/sh
# traffic

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
put_template 0  "28/2d/31"
put_template 1  "93/4e/46"
put_template 2  "63/72/68"
put_template 3  "c7/9e/84"
put_template 4  "51/5e/67"
put_template 5  "71/5f/5e"
put_template 6  "5c/6f/7d"
put_template 7  "cf/b9/a8"
put_template 8  "4e/57/5e"
put_template 9  "93/4e/46"
put_template 10 "63/72/70"
put_template 11 "c7/9e/84"
put_template 12 "51/5e/67"
put_template 13 "71/5f/5e"
put_template 14 "5c/6f/7d"
put_template 15 "dd/ce/c2"

color_foreground="cf/b9/a8"
color_background="27/2c/30"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cfb9a8"
  put_template_custom Ph "272c30"
  put_template_custom Pi "cfb9a8"
  put_template_custom Pj "cfb9a8"
  put_template_custom Pk "272c30"
  put_template_custom Pl "cfb9a8"
  put_template_custom Pm "272c30"
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
