#!/bin/sh
# Glacier Mint

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
put_template 0  "2f/46/40"
put_template 1  "c0/50/45"
put_template 2  "3d/90/60"
put_template 3  "a4/82/24"
put_template 4  "3f/7a/b8"
put_template 5  "88/58/ab"
put_template 6  "26/94/8e"
put_template 7  "ac/c2/ba"
put_template 8  "6c/83/7c"
put_template 9  "d7/64/58"
put_template 10 "4a/a9/71"
put_template 11 "bb/98/30"
put_template 12 "51/90/cc"
put_template 13 "9e/6e/c1"
put_template 14 "32/ad/a6"
put_template 15 "fb/ff/fd"

color_foreground="2f/46/40"
color_background="f0/f9/f6"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2f4640"
  put_template_custom Ph "f0f9f6"
  put_template_custom Pi "2f4640"
  put_template_custom Pj "c6ebdd"
  put_template_custom Pk "2f4640"
  put_template_custom Pl "2aa88a"
  put_template_custom Pm "f0f9f6"
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
