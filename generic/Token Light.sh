#!/bin/sh
# Token Light

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
put_template 0  "2a/29/20"
put_template 1  "b0/55/55"
put_template 2  "3f/64/3c"
put_template 3  "6e/5c/20"
put_template 4  "52/75/94"
put_template 5  "7c/61/9a"
put_template 6  "2d/6c/6c"
put_template 7  "b5/b2/ab"
put_template 8  "6c/67/5f"
put_template 9  "9a/49/29"
put_template 10 "3a/5e/37"
put_template 11 "87/60/32"
put_template 12 "48/6a/88"
put_template 13 "6f/57/8c"
put_template 14 "28/63/63"
put_template 15 "fa/f9/f5"

color_foreground="2a/29/20"
color_background="fa/f9/f5"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2a2920"
  put_template_custom Ph "faf9f5"
  put_template_custom Pi "2a2920"
  put_template_custom Pj "dddcd6"
  put_template_custom Pk "2a2920"
  put_template_custom Pl "2a2920"
  put_template_custom Pm "faf9f5"
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
