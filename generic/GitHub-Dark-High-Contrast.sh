#!/bin/sh
# GitHub-Dark-High-Contrast

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
put_template 0  "7a/82/8e"
put_template 1  "ff/94/92"
put_template 2  "26/cd/4d"
put_template 3  "f0/b7/2f"
put_template 4  "71/b7/ff"
put_template 5  "cb/9e/ff"
put_template 6  "39/c5/cf"
put_template 7  "d9/de/e3"
put_template 8  "9e/a7/b3"
put_template 9  "ff/b1/af"
put_template 10 "4a/e1/68"
put_template 11 "f7/c8/43"
put_template 12 "91/cb/ff"
put_template 13 "db/b7/ff"
put_template 14 "56/d4/dd"
put_template 15 "ff/ff/ff"

color_foreground="f0/f3/f6"
color_background="0a/0c/10"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f0f3f6"
  put_template_custom Ph "0a0c10"
  put_template_custom Pi "f0f3f6"
  put_template_custom Pj "f0f3f6"
  put_template_custom Pk "0a0c10"
  put_template_custom Pl "71b7ff"
  put_template_custom Pm "71b7ff"
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
