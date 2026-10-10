#!/bin/sh
# Blood Moon

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
put_template 0  "bb/aa/ad"
put_template 1  "f1/7c/78"
put_template 2  "9c/ca/8e"
put_template 3  "e5/c3/6b"
put_template 4  "8d/b9/d8"
put_template 5  "cd/97/b7"
put_template 6  "7f/c6/c1"
put_template 7  "ff/f0/dc"
put_template 8  "cf/bf/c1"
put_template 9  "f4/98/94"
put_template 10 "b0/d6/a3"
put_template 11 "ed/d3/89"
put_template 12 "a8/cb/e2"
put_template 13 "da/b0/c7"
put_template 14 "9d/d5/d0"
put_template 15 "ff/fa/f0"

color_foreground="ff/f0/dc"
color_background="4b/08/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0dc"
  put_template_custom Ph "4b080d"
  put_template_custom Pi "ff5b5f"
  put_template_custom Pj "741b22"
  put_template_custom Pk "fff8ec"
  put_template_custom Pl "ff454b"
  put_template_custom Pm "4b080d"
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
