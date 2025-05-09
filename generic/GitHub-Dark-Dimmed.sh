#!/bin/sh
# GitHub-Dark-Dimmed

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
put_template 0  "54/5d/68"
put_template 1  "f4/70/67"
put_template 2  "57/ab/5a"
put_template 3  "c6/90/26"
put_template 4  "53/9b/f5"
put_template 5  "b0/83/f0"
put_template 6  "39/c5/cf"
put_template 7  "90/9d/ab"
put_template 8  "63/6e/7b"
put_template 9  "ff/93/8a"
put_template 10 "6b/c4/6d"
put_template 11 "da/aa/3f"
put_template 12 "6c/b6/ff"
put_template 13 "dc/bd/fb"
put_template 14 "56/d4/dd"
put_template 15 "cd/d9/e5"

color_foreground="ad/ba/c7"
color_background="22/27/2e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "adbac7"
  put_template_custom Ph "22272e"
  put_template_custom Pi "adbac7"
  put_template_custom Pj "adbac7"
  put_template_custom Pk "22272e"
  put_template_custom Pl "539bf5"
  put_template_custom Pm "539bf5"
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
