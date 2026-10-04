#!/bin/sh
# Petrified

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
put_template 0  "c7/c0/ba"
put_template 1  "ee/96/76"
put_template 2  "82/c7/94"
put_template 3  "e5/c0/5c"
put_template 4  "80/bd/d2"
put_template 5  "cc/9f/c1"
put_template 6  "75/cc/c7"
put_template 7  "ff/f0/dc"
put_template 8  "d6/d0/ca"
put_template 9  "f4/aa/8d"
put_template 10 "9b/d4/a7"
put_template 11 "ef/d1/7d"
put_template 12 "9d/cd/dd"
put_template 13 "da/b6/cf"
put_template 14 "94/da/d5"
put_template 15 "ff/f9/ed"

color_foreground="ff/f0/dc"
color_background="40/36/37"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0dc"
  put_template_custom Ph "403637"
  put_template_custom Pi "eab060"
  put_template_custom Pj "625456"
  put_template_custom Pk "fff8ea"
  put_template_custom Pl "f0b65c"
  put_template_custom Pm "403637"
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
