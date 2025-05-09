#!/bin/sh
# Night Owlish Light

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
put_template 0  "01/16/27"
put_template 1  "d3/42/3e"
put_template 2  "2a/a2/98"
put_template 3  "da/aa/01"
put_template 4  "48/76/d6"
put_template 5  "40/3f/53"
put_template 6  "08/91/6a"
put_template 7  "7a/81/81"
put_template 8  "7a/81/81"
put_template 9  "f7/6e/6e"
put_template 10 "49/d0/c5"
put_template 11 "da/c2/6b"
put_template 12 "5c/a7/e4"
put_template 13 "69/70/98"
put_template 14 "00/c9/90"
put_template 15 "98/9f/b1"

color_foreground="40/3f/53"
color_background="ff/ff/ff"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "403f53"
  put_template_custom Ph "ffffff"
  put_template_custom Pi "403f53"
  put_template_custom Pj "f2f2f2"
  put_template_custom Pk "403f53"
  put_template_custom Pl "403f53"
  put_template_custom Pm "fbfbfb"
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
