#!/bin/sh
# Rainbows and Unicorns Sorbet

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
put_template 0  "3a/2d/48"
put_template 1  "ff/9e/b5"
put_template 2  "a8/e6/c3"
put_template 3  "ff/e8/a3"
put_template 4  "a7/c7/ff"
put_template 5  "d7/b3/ff"
put_template 6  "9f/e8/e6"
put_template 7  "e4/d6/ec"
put_template 8  "8a/78/9e"
put_template 9  "ff/be/98"
put_template 10 "c6/f3/d9"
put_template 11 "ff/f2/c7"
put_template 12 "c7/db/ff"
put_template 13 "e8/d1/ff"
put_template 14 "c5/f4/f2"
put_template 15 "ff/ff/ff"

color_foreground="f3/e8/f5"
color_background="24/1b/2f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f3e8f5"
  put_template_custom Ph "241b2f"
  put_template_custom Pi "f3e8f5"
  put_template_custom Pj "d7b3ff"
  put_template_custom Pk "241b2f"
  put_template_custom Pl "ff9eb5"
  put_template_custom Pm "241b2f"
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
