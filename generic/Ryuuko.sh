#!/bin/sh
# Ryuuko

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
put_template 0  "2c/39/41"
put_template 1  "86/5f/5b"
put_template 2  "66/90/7d"
put_template 3  "b1/a9/90"
put_template 4  "6a/8e/95"
put_template 5  "b1/8a/73"
put_template 6  "88/b2/ac"
put_template 7  "ec/ec/ec"
put_template 8  "5d/70/79"
put_template 9  "86/5f/5b"
put_template 10 "66/90/7d"
put_template 11 "b1/a9/90"
put_template 12 "6a/8e/95"
put_template 13 "b1/8a/73"
put_template 14 "88/b2/ac"
put_template 15 "ec/ec/ec"

color_foreground="ec/ec/ec"
color_background="2c/39/41"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ececec"
  put_template_custom Ph "2c3941"
  put_template_custom Pi "819090"
  put_template_custom Pj "002831"
  put_template_custom Pk "819090"
  put_template_custom Pl "ececec"
  put_template_custom Pm "002831"
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
