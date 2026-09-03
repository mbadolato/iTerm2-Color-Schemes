#!/bin/sh
# Isocon Light

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
put_template 0  "ee/f3/ea"
put_template 1  "c3/3f/3d"
put_template 2  "34/7b/47"
put_template 3  "85/6b/31"
put_template 4  "2f/6b/cf"
put_template 5  "92/42/d6"
put_template 6  "30/6f/72"
put_template 7  "6e/6e/6e"
put_template 8  "8c/8c/8c"
put_template 9  "d0/27/2f"
put_template 10 "1f/7d/3f"
put_template 11 "89/6a/1c"
put_template 12 "1a/67/e1"
put_template 13 "98/2a/e9"
put_template 14 "1c/71/75"
put_template 15 "6e/6e/6e"

color_foreground="6e/6e/6e"
color_background="ee/f3/ea"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "6e6e6e"
  put_template_custom Ph "eef3ea"
  put_template_custom Pi "6e6e6e"
  put_template_custom Pj "6e6e6e"
  put_template_custom Pk "eef3ea"
  put_template_custom Pl "6e6e6e"
  put_template_custom Pm "eef3ea"
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
