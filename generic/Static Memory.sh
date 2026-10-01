#!/bin/sh
# Static Memory

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
put_template 0  "2c/32/31"
put_template 1  "85/23/23"
put_template 2  "14/5b/38"
put_template 3  "65/4d/00"
put_template 4  "17/46/8d"
put_template 5  "60/30/87"
put_template 6  "00/58/66"
put_template 7  "3d/43/42"
put_template 8  "48/4e/4d"
put_template 9  "91/29/29"
put_template 10 "18/60/3e"
put_template 11 "6d/53/00"
put_template 12 "12/3a/78"
put_template 13 "67/38/8f"
put_template 14 "00/4b/57"
put_template 15 "46/4c/4b"

color_foreground="1b/20/20"
color_background="f7/f8/f6"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1b2020"
  put_template_custom Ph "f7f8f6"
  put_template_custom Pi "375d5a"
  put_template_custom Pj "dde3e0"
  put_template_custom Pk "1b2020"
  put_template_custom Pl "386b68"
  put_template_custom Pm "f7f8f6"
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
