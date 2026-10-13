#!/bin/sh
# iglass Light

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
put_template 0  "1d/1d/1f"
put_template 1  "92/00/0b"
put_template 2  "00/52/1b"
put_template 3  "76/32/00"
put_template 4  "00/35/bb"
put_template 5  "6a/23/8a"
put_template 6  "00/4a/6e"
put_template 7  "ba/ba/bf"
put_template 8  "60/5f/64"
put_template 9  "c3/00/06"
put_template 10 "00/70/19"
put_template 11 "76/5d/00"
put_template 12 "00/5c/c5"
put_template 13 "90/2f/bd"
put_template 14 "00/67/8d"
put_template 15 "e5/e5/ea"

color_foreground="1d/1d/1f"
color_background="f5/f5/f7"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1d1d1f"
  put_template_custom Ph "f5f5f7"
  put_template_custom Pi "1d1d1f"
  put_template_custom Pj "bad7f9"
  put_template_custom Pk "1d1d1f"
  put_template_custom Pl "005cc5"
  put_template_custom Pm "f5f5f7"
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
