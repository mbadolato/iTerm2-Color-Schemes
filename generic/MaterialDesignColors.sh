#!/bin/sh
# MaterialDesignColors

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
put_template 0  "43/5b/67"
put_template 1  "fc/38/41"
put_template 2  "5c/f1/9e"
put_template 3  "fe/d0/32"
put_template 4  "37/b6/ff"
put_template 5  "fc/22/6e"
put_template 6  "59/ff/d1"
put_template 7  "ff/ff/ff"
put_template 8  "a1/b0/b8"
put_template 9  "fc/74/6d"
put_template 10 "ad/f7/be"
put_template 11 "fe/e1/6c"
put_template 12 "70/cf/ff"
put_template 13 "fc/66/9b"
put_template 14 "9a/ff/e6"
put_template 15 "ff/ff/ff"

color_foreground="e7/eb/ed"
color_background="1d/26/2a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e7ebed"
  put_template_custom Ph "1d262a"
  put_template_custom Pi "eaeaea"
  put_template_custom Pj "4e6a78"
  put_template_custom Pk "e7ebed"
  put_template_custom Pl "eaeaea"
  put_template_custom Pm "000000"
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
