#!/bin/sh
# branch

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
put_template 0  "35/24/1c"
put_template 1  "c2/56/2d"
put_template 2  "96/a6/5e"
put_template 3  "d2/9b/5a"
put_template 4  "3b/8e/8c"
put_template 5  "c4/7e/5b"
put_template 6  "63/9a/90"
put_template 7  "cf/c1/a9"
put_template 8  "56/4a/45"
put_template 9  "c2/56/2d"
put_template 10 "96/a6/5e"
put_template 11 "d2/9b/5a"
put_template 12 "3b/8e/8c"
put_template 13 "c4/7e/5b"
put_template 14 "63/9a/90"
put_template 15 "cf/c1/a9"

color_foreground="cf/c1/a9"
color_background="32/22/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cfc1a9"
  put_template_custom Ph "32221a"
  put_template_custom Pi "cfc1a9"
  put_template_custom Pj "32221a"
  put_template_custom Pk "cfc1a9"
  put_template_custom Pl "cfc1a9"
  put_template_custom Pm "32221a"
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
