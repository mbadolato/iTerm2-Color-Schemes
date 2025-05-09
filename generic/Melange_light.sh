#!/bin/sh
# Melange_light

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
put_template 0  "e9/e1/db"
put_template 1  "c7/7b/8b"
put_template 2  "6e/9b/72"
put_template 3  "bc/5c/00"
put_template 4  "78/92/bd"
put_template 5  "be/79/bb"
put_template 6  "73/97/97"
put_template 7  "7d/66/58"
put_template 8  "a9/8a/78"
put_template 9  "bf/00/21"
put_template 10 "3a/68/4a"
put_template 11 "a0/6d/00"
put_template 12 "46/5a/a4"
put_template 13 "90/41/80"
put_template 14 "3d/65/68"
put_template 15 "54/43/3a"

color_foreground="54/43/3a"
color_background="f1/f1/f1"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "54433a"
  put_template_custom Ph "f1f1f1"
  put_template_custom Pi "f1f1f1"
  put_template_custom Pj "54433a"
  put_template_custom Pk "d9d3ce"
  put_template_custom Pl "54433a"
  put_template_custom Pm "f1f1f1"
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
