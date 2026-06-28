#!/bin/sh
# Forge Ember

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
put_template 0  "24/18/10"
put_template 1  "ff/47/33"
put_template 2  "c4/c2/4a"
put_template 3  "ff/b3/47"
put_template 4  "f0/a2/4f"
put_template 5  "ff/6a/4d"
put_template 6  "ff/d2/7a"
put_template 7  "e6/d2/b6"
put_template 8  "7a/62/48"
put_template 9  "ff/47/33"
put_template 10 "c4/c2/4a"
put_template 11 "ff/7a/2d"
put_template 12 "f0/a2/4f"
put_template 13 "ff/6a/4d"
put_template 14 "ff/d2/7a"
put_template 15 "f4/e2/c8"

color_foreground="f4/e2/c8"
color_background="14/0c/07"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f4e2c8"
  put_template_custom Ph "140c07"
  put_template_custom Pi "f4e2c8"
  put_template_custom Pj "33220f"
  put_template_custom Pk "544c47"
  put_template_custom Pl "ff6a1f"
  put_template_custom Pm "140c07"
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
