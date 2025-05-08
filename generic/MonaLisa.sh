#!/bin/sh
# MonaLisa

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
put_template 0  "35/1b/0e"
put_template 1  "9b/29/1c"
put_template 2  "63/62/32"
put_template 3  "c3/6e/28"
put_template 4  "51/5c/5d"
put_template 5  "9b/1d/29"
put_template 6  "58/80/56"
put_template 7  "f7/d7/5c"
put_template 8  "87/42/28"
put_template 9  "ff/43/31"
put_template 10 "b4/b2/64"
put_template 11 "ff/95/66"
put_template 12 "9e/b2/b4"
put_template 13 "ff/5b/6a"
put_template 14 "8a/cd/8f"
put_template 15 "ff/e5/98"

color_foreground="f7/d6/6a"
color_background="12/0b/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7d66a"
  put_template_custom Ph "120b0d"
  put_template_custom Pi "fee4a0"
  put_template_custom Pj "f7d66a"
  put_template_custom Pk "120b0d"
  put_template_custom Pl "c46c32"
  put_template_custom Pm "120b0d"
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
