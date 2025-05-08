#!/bin/sh
# iceberg-light

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
put_template 0  "dc/df/e7"
put_template 1  "cc/51/7a"
put_template 2  "66/8e/3d"
put_template 3  "c5/73/39"
put_template 4  "2d/53/9e"
put_template 5  "77/59/b4"
put_template 6  "3f/83/a6"
put_template 7  "33/37/4c"
put_template 8  "83/89/a3"
put_template 9  "cc/37/68"
put_template 10 "59/80/30"
put_template 11 "b6/66/2d"
put_template 12 "22/47/8e"
put_template 13 "68/45/ad"
put_template 14 "32/76/98"
put_template 15 "26/2a/3f"

color_foreground="33/37/4c"
color_background="e8/e9/ec"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "33374c"
  put_template_custom Ph "e8e9ec"
  put_template_custom Pi "33374c"
  put_template_custom Pj "33374c"
  put_template_custom Pk "e8e9ec"
  put_template_custom Pl "33374c"
  put_template_custom Pm "e8e9ec"
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
