#!/bin/sh
# seoulbones_light

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
put_template 0  "e2/e2/e2"
put_template 1  "dc/52/84"
put_template 2  "62/85/62"
put_template 3  "c4/85/62"
put_template 4  "00/84/a3"
put_template 5  "89/67/88"
put_template 6  "00/85/86"
put_template 7  "55/55/55"
put_template 8  "bf/ba/bb"
put_template 9  "be/3c/6d"
put_template 10 "48/72/49"
put_template 11 "a7/6b/48"
put_template 12 "00/6f/89"
put_template 13 "7f/4c/7e"
put_template 14 "00/6f/70"
put_template 15 "77/77/77"

color_foreground="55/55/55"
color_background="e2/e2/e2"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "555555"
  put_template_custom Ph "e2e2e2"
  put_template_custom Pi "bfbabb"
  put_template_custom Pj "cccccc"
  put_template_custom Pk "555555"
  put_template_custom Pl "555555"
  put_template_custom Pm "e2e2e2"
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
