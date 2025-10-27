#!/bin/sh
# No Clown Fiesta

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
put_template 0  "15/15/15"
put_template 1  "b4/69/58"
put_template 2  "90/a9/59"
put_template 3  "f4/bf/75"
put_template 4  "ba/d7/ff"
put_template 5  "aa/75/9f"
put_template 6  "88/af/a2"
put_template 7  "e1/e1/e1"
put_template 8  "72/72/72"
put_template 9  "7e/97/ab"
put_template 10 "90/a9/59"
put_template 11 "f4/bf/75"
put_template 12 "ba/d7/ff"
put_template 13 "aa/75/9f"
put_template 14 "88/af/a2"
put_template 15 "af/af/af"

color_foreground="e0/e1/e4"
color_background="10/10/10"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0e1e4"
  put_template_custom Ph "101010"
  put_template_custom Pi "e0e1e4"
  put_template_custom Pj "696d79"
  put_template_custom Pk "e0e1e4"
  put_template_custom Pl "e0e1e4"
  put_template_custom Pm "18191b"
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
