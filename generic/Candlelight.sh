#!/bin/sh
# Candlelight

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
put_template 0  "c8/b9/9e"
put_template 1  "e8/96/61"
put_template 2  "9a/b5/7c"
put_template 3  "df/bb/53"
put_template 4  "83/ae/bd"
put_template 5  "bc/91/a4"
put_template 6  "79/b8/ae"
put_template 7  "f8/e7/c4"
put_template 8  "cf/c1/aa"
put_template 9  "eb/a3/74"
put_template 10 "a6/be/8c"
put_template 11 "e3/c3/68"
put_template 12 "92/b8/c5"
put_template 13 "c4/9e/af"
put_template 14 "89/c1/b8"
put_template 15 "f9/ea/cb"

color_foreground="f8/e7/c4"
color_background="43/27/08"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8e7c4"
  put_template_custom Ph "432708"
  put_template_custom Pi "e3c368"
  put_template_custom Pj "cfc1aa"
  put_template_custom Pk "a09172"
  put_template_custom Pl "eba374"
  put_template_custom Pm "432708"
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
