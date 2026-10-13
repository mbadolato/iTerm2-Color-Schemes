#!/bin/sh
# Smoke on the Terminal

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
put_template 0  "a8/b2/b8"
put_template 1  "df/8d/80"
put_template 2  "a7/c9/96"
put_template 3  "e4/be/83"
put_template 4  "a4/b5/e2"
put_template 5  "cf/9b/e2"
put_template 6  "8f/cb/d2"
put_template 7  "f5/e8/f4"
put_template 8  "b9/c1/c6"
put_template 9  "e3/9b/8f"
put_template 10 "b2/cf/a3"
put_template 11 "e7/c6/92"
put_template 12 "af/be/e5"
put_template 13 "d5/a7/e5"
put_template 14 "9c/d1/d7"
put_template 15 "f7/ed/f6"

color_foreground="f5/e8/f4"
color_background="30/24/3a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5e8f4"
  put_template_custom Ph "30243a"
  put_template_custom Pi "f7edf6"
  put_template_custom Pj "553f55"
  put_template_custom Pk "f5e8f4"
  put_template_custom Pl "e7c692"
  put_template_custom Pm "30243a"
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
