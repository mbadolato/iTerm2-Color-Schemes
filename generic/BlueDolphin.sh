#!/bin/sh
# BlueDolphin

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
put_template 0  "29/2d/3e"
put_template 1  "ff/82/88"
put_template 2  "b4/e8/8d"
put_template 3  "f4/d6/9f"
put_template 4  "82/aa/ff"
put_template 5  "e9/c1/ff"
put_template 6  "89/eb/ff"
put_template 7  "d0/d0/d0"
put_template 8  "43/47/58"
put_template 9  "ff/8b/92"
put_template 10 "dd/ff/a7"
put_template 11 "ff/e5/85"
put_template 12 "9c/c4/ff"
put_template 13 "dd/b0/f6"
put_template 14 "a3/f7/ff"
put_template 15 "ff/ff/ff"

color_foreground="c5/f2/ff"
color_background="00/69/84"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c5f2ff"
  put_template_custom Ph "006984"
  put_template_custom Pi "eeeeee"
  put_template_custom Pj "2baeca"
  put_template_custom Pk "eceff1"
  put_template_custom Pl "ffcc00"
  put_template_custom Pm "292d3e"
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
