#!/bin/sh
# Lumina Espresso Dark

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
put_template 0  "35/21/14"
put_template 1  "d4/71/69"
put_template 2  "92/c7/9c"
put_template 3  "fd/cf/90"
put_template 4  "92/bb/ea"
put_template 5  "dc/8e/bb"
put_template 6  "b7/dc/e5"
put_template 7  "c4/bb/ad"
put_template 8  "96/86/78"
put_template 9  "e1/93/8b"
put_template 10 "aa/e1/b5"
put_template 11 "ff/e3/be"
put_template 12 "b0/d5/ff"
put_template 13 "ef/ad/d2"
put_template 14 "be/f2/ff"
put_template 15 "e5/db/cd"

color_foreground="e5/db/cd"
color_background="2f/1d/11"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e5dbcd"
  put_template_custom Ph "2f1d11"
  put_template_custom Pi "e5dbcd"
  put_template_custom Pj "51472a"
  put_template_custom Pk "e5dbcd"
  put_template_custom Pl "e5dbcd"
  put_template_custom Pm "2f1d11"
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
