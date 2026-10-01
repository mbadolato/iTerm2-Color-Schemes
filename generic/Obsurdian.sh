#!/bin/sh
# Obsurdian

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
put_template 0  "b8/b8/b8"
put_template 1  "ff/6b/6b"
put_template 2  "66/d9/8b"
put_template 3  "ff/e3/7a"
put_template 4  "82/aa/ff"
put_template 5  "ff/8f/d1"
put_template 6  "8b/e9/f4"
put_template 7  "f0/f0/f0"
put_template 8  "c7/c7/c7"
put_template 9  "ff/85/85"
put_template 10 "82/e6/a0"
put_template 11 "ff/eb/96"
put_template 12 "9a/ba/ff"
put_template 13 "ff/a8/dc"
put_template 14 "a4/f1/f7"
put_template 15 "ff/ff/ff"

color_foreground="f5/f5/f5"
color_background="0a/0a/0a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5f5f5"
  put_template_custom Ph "0a0a0a"
  put_template_custom Pi "ffb000"
  put_template_custom Pj "3a3a3a"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "ffd54a"
  put_template_custom Pm "0a0a0a"
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
