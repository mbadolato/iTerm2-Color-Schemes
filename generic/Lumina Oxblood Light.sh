#!/bin/sh
# Lumina Oxblood Light

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
put_template 0  "4f/3c/45"
put_template 1  "98/2e/24"
put_template 2  "28/78/49"
put_template 3  "9f/62/02"
put_template 4  "35/65/9f"
put_template 5  "86/4a/81"
put_template 6  "3d/60/6e"
put_template 7  "7e/69/73"
put_template 8  "79/5d/6a"
put_template 9  "71/2c/24"
put_template 10 "16/63/38"
put_template 11 "84/50/00"
put_template 12 "21/51/89"
put_template 13 "70/37/6b"
put_template 14 "00/4f/66"
put_template 15 "9f/88/93"

color_foreground="4f/3c/45"
color_background="f9/f4/f5"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "4f3c45"
  put_template_custom Ph "f9f4f5"
  put_template_custom Pi "4f3c45"
  put_template_custom Pj "ebd5dd"
  put_template_custom Pk "4f3c45"
  put_template_custom Pl "4f3c45"
  put_template_custom Pm "f9f4f5"
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
