#!/bin/sh
# Painted Desert

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
put_template 0  "d7/c7/c8"
put_template 1  "ff/a0/8e"
put_template 2  "99/d6/a8"
put_template 3  "f2/d0/71"
put_template 4  "9c/cb/ed"
put_template 5  "e7/ac/d7"
put_template 6  "92/de/d8"
put_template 7  "ff/f0/df"
put_template 8  "e4/d6/d7"
put_template 9  "ff/b5/a4"
put_template 10 "b0/e0/ba"
put_template 11 "ff/e0/91"
put_template 12 "b7/da/f2"
put_template 13 "f0/c2/e0"
put_template 14 "b1/e9/e4"
put_template 15 "ff/fa/f2"

color_foreground="ff/f0/df"
color_background="59/31/48"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0df"
  put_template_custom Ph "593148"
  put_template_custom Pi "f6b56e"
  put_template_custom Pj "774b63"
  put_template_custom Pk "fff7ec"
  put_template_custom Pl "f4c05d"
  put_template_custom Pm "593148"
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
