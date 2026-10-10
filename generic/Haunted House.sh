#!/bin/sh
# Haunted House

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
put_template 0  "b9/c2/c9"
put_template 1  "ed/9b/8c"
put_template 2  "9f/cb/a7"
put_template 3  "e5/cb/7c"
put_template 4  "9f/c7/e5"
put_template 5  "c2/ad/d8"
put_template 6  "93/d0/d0"
put_template 7  "f1/f4/ed"
put_template 8  "cc/d3/d8"
put_template 9  "f1/af/a3"
put_template 10 "b3/d8/ba"
put_template 11 "ed/da/99"
put_template 12 "b8/d6/ec"
put_template 13 "d0/c2/e0"
put_template 14 "ad/dd/dd"
put_template 15 "ff/ff/ff"

color_foreground="f1/f4/ed"
color_background="23/39/4e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f1f4ed"
  put_template_custom Ph "23394e"
  put_template_custom Pi "b7cde2"
  put_template_custom Pj "40566a"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "d5e2ee"
  put_template_custom Pm "23394e"
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
