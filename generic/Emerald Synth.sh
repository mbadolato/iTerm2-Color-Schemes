#!/bin/sh
# Emerald Synth

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
put_template 0  "0a/01/18"
put_template 1  "ff/2a/6d"
put_template 2  "00/e6/7e"
put_template 3  "ff/cc/66"
put_template 4  "8b/9c/f7"
put_template 5  "ff/79/c6"
put_template 6  "4d/d0/e1"
put_template 7  "f0/e6/ff"
put_template 8  "6a/55/85"
put_template 9  "ff/5c/8a"
put_template 10 "40/ff/dd"
put_template 11 "ff/e0/99"
put_template 12 "b0/b8/fc"
put_template 13 "ff/9e/d0"
put_template 14 "7e/e0/ec"
put_template 15 "ff/ff/ff"

color_foreground="00/ff/cc"
color_background="0d/02/21"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "00ffcc"
  put_template_custom Ph "0d0221"
  put_template_custom Pi "00ffcc"
  put_template_custom Pj "2e6b5f"
  put_template_custom Pk "00ffcc"
  put_template_custom Pl "ff79c6"
  put_template_custom Pm "0d0221"
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
