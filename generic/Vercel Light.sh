#!/bin/sh
# Vercel Light

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
put_template 0  "24/29/2f"
put_template 1  "cf/2f/36"
put_template 2  "18/70/3a"
put_template 3  "8a/53/00"
put_template 4  "1a/5f/b4"
put_template 5  "7e/3a/b8"
put_template 6  "0b/72/68"
put_template 7  "4f/53/59"
put_template 8  "65/6a/70"
put_template 9  "a8/24/2b"
put_template 10 "0f/5a/2c"
put_template 11 "6b/3f/00"
put_template 12 "12/4a/8c"
put_template 13 "62/2a/92"
put_template 14 "08/5a/52"
put_template 15 "17/17/17"

color_foreground="24/29/2f"
color_background="fb/fb/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "24292f"
  put_template_custom Ph "fbfbfa"
  put_template_custom Pi "24292f"
  put_template_custom Pj "dce3ec"
  put_template_custom Pk "24292f"
  put_template_custom Pl "24292f"
  put_template_custom Pm "fbfbfa"
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
