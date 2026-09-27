#!/bin/sh
# Arizona Monsoon

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
put_template 0  "1f/29/37"
put_template 1  "e3/5d/4a"
put_template 2  "7c/c4/6b"
put_template 3  "e6/b4/41"
put_template 4  "5b/9d/ff"
put_template 5  "c6/78/dd"
put_template 6  "2d/d4/bf"
put_template 7  "e8/e2/d1"
put_template 8  "4b/55/63"
put_template 9  "ff/7b/6b"
put_template 10 "98/d9/8e"
put_template 11 "ff/d1/66"
put_template 12 "7d/bf/ff"
put_template 13 "d4/8c/ff"
put_template 14 "52/e0/cf"
put_template 15 "f7/ea/d1"

color_foreground="e6/e8/ed"
color_background="0a/0f/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e8ed"
  put_template_custom Ph "0a0f14"
  put_template_custom Pi "cbd5e1"
  put_template_custom Pj "334155"
  put_template_custom Pk "e6e8ed"
  put_template_custom Pl "f4d06f"
  put_template_custom Pm "0a0f14"
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
