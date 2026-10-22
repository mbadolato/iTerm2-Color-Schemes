#!/bin/sh
# Lumina Rayleigh Dark

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
put_template 0  "18/1c/33"
put_template 1  "da/6d/65"
put_template 2  "96/d2/a1"
put_template 3  "f8/c9/70"
put_template 4  "7c/bd/ff"
put_template 5  "ed/9e/cb"
put_template 6  "ac/da/e6"
put_template 7  "b4/bb/c9"
put_template 8  "7d/85/9f"
put_template 9  "e6/90/88"
put_template 10 "af/ed/ba"
put_template 11 "ff/e4/b4"
put_template 12 "ae/d6/ff"
put_template 13 "ff/be/e2"
put_template 14 "bf/f2/ff"
put_template 15 "d4/db/ea"

color_foreground="d4/db/ea"
color_background="14/18/2c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d4dbea"
  put_template_custom Ph "14182c"
  put_template_custom Pi "d4dbea"
  put_template_custom Pj "2d3e5d"
  put_template_custom Pk "d4dbea"
  put_template_custom Pl "d4dbea"
  put_template_custom Pm "14182c"
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
