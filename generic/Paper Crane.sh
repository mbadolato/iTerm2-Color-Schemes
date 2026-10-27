#!/bin/sh
# Paper Crane

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
put_template 0  "42/48/45"
put_template 1  "a7/4e/45"
put_template 2  "53/76/5e"
put_template 3  "8a/6c/2b"
put_template 4  "4c/68/8f"
put_template 5  "80/5b/83"
put_template 6  "3e/7b/7a"
put_template 7  "62/6c/66"
put_template 8  "77/7d/76"
put_template 9  "bf/63/54"
put_template 10 "66/8a/6d"
put_template 11 "a3/83/3d"
put_template 12 "60/7e/aa"
put_template 13 "96/6f/9b"
put_template 14 "52/93/92"
put_template 15 "45/4f/49"

color_foreground="35/3b/3a"
color_background="f5/f1/e8"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "353b3a"
  put_template_custom Ph "f5f1e8"
  put_template_custom Pi "353b3a"
  put_template_custom Pj "b8cdb6"
  put_template_custom Pk "353b3a"
  put_template_custom Pl "b85d4b"
  put_template_custom Pm "f5f1e8"
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
