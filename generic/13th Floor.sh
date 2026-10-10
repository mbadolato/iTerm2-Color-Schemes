#!/bin/sh
# 13th Floor

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
put_template 0  "bd/aa/ad"
put_template 1  "e0/7f/70"
put_template 2  "9e/ae/80"
put_template 3  "d0/af/63"
put_template 4  "84/9c/af"
put_template 5  "b7/8e/a6"
put_template 6  "7b/b2/aa"
put_template 7  "f2/e2/c8"
put_template 8  "c5/b4/b7"
put_template 9  "e4/8e/81"
put_template 10 "aa/b8/8f"
put_template 11 "d6/b9/76"
put_template 12 "93/a8/b9"
put_template 13 "c0/9c/b1"
put_template 14 "8b/bb/b4"
put_template 15 "f4/e5/cf"

color_foreground="f2/e2/c8"
color_background="4a/07/10"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2e2c8"
  put_template_custom Ph "4a0710"
  put_template_custom Pi "d6b976"
  put_template_custom Pj "c5b4b7"
  put_template_custom Pk "fff2dc"
  put_template_custom Pl "e48e81"
  put_template_custom Pm "4a0710"
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
