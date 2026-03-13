#!/bin/sh
# Monospace Light

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
put_template 0  "33/3e/4f"
put_template 1  "d0/39/41"
put_template 2  "00/7b/49"
put_template 3  "a6/59/21"
put_template 4  "3c/60/dd"
put_template 5  "6f/4c/de"
put_template 6  "00/75/a2"
put_template 7  "5d/6a/7d"
put_template 8  "00/00/00"
put_template 9  "a5/24/30"
put_template 10 "00/52/2f"
put_template 11 "90/4b/1a"
put_template 12 "00/24/87"
put_template 13 "4d/21/bb"
put_template 14 "00/60/7e"
put_template 15 "47/53/65"

color_foreground="47/53/65"
color_background="f4/f7/fd"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "475365"
  put_template_custom Ph "f4f7fd"
  put_template_custom Pi "1f2939"
  put_template_custom Pj "c7d3ff"
  put_template_custom Pk "1f2939"
  put_template_custom Pl "6f4cde"
  put_template_custom Pm "f4f7fd"
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
