#!/bin/sh
# Lumina Olive Light

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
put_template 0  "30/2e/16"
put_template 1  "8a/1f/1f"
put_template 2  "30/62/4e"
put_template 3  "a1/60/10"
put_template 4  "32/64/a3"
put_template 5  "8e/4c/89"
put_template 6  "00/6f/83"
put_template 7  "72/70/56"
put_template 8  "6a/6b/54"
put_template 9  "64/20/1e"
put_template 10 "00/51/39"
put_template 11 "87/4e/00"
put_template 12 "1e/50/8c"
put_template 13 "76/3a/72"
put_template 14 "00/59/6a"
put_template 15 "91/8f/74"

color_foreground="30/2e/16"
color_background="f7/f6/e5"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "302e16"
  put_template_custom Ph "f7f6e5"
  put_template_custom Pi "302e16"
  put_template_custom Pj "c6cda8"
  put_template_custom Pk "302e16"
  put_template_custom Pl "302e16"
  put_template_custom Pm "f7f6e5"
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
