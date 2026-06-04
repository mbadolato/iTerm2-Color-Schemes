#!/bin/sh
# Aardvark Ink

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
put_template 0  "22/27/34"
put_template 1  "c2/62/65"
put_template 2  "52/aa/60"
put_template 3  "ad/9b/49"
put_template 4  "48/7f/d4"
put_template 5  "af/5b/d1"
put_template 6  "26/9d/9a"
put_template 7  "5a/63/77"
put_template 8  "3a/41/52"
put_template 9  "e4/83/83"
put_template 10 "75/cf/84"
put_template 11 "c7/b4/61"
put_template 12 "76/a8/f2"
put_template 13 "d5/8b/f0"
put_template 14 "52/c4/c0"
put_template 15 "df/e5/ee"

color_foreground="b4/bc/ca"
color_background="0f/14/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "b4bcca"
  put_template_custom Ph "0f141f"
  put_template_custom Pi "b4bcca"
  put_template_custom Pj "2a3645"
  put_template_custom Pk "dfe5ee"
  put_template_custom Pl "b4bcca"
  put_template_custom Pm "0f141f"
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
