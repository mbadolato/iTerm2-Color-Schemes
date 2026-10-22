#!/bin/sh
# Lumina Canopy Light

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
put_template 0  "3b/43/3a"
put_template 1  "9c/2e/2c"
put_template 2  "00/79/53"
put_template 3  "a0/61/15"
put_template 4  "1d/5c/99"
put_template 5  "9e/32/7d"
put_template 6  "00/70/83"
put_template 7  "68/70/67"
put_template 8  "51/66/5c"
put_template 9  "74/2d/2a"
put_template 10 "00/62/43"
put_template 11 "87/4e/00"
put_template 12 "0c/48/7f"
put_template 13 "76/35/60"
put_template 14 "00/5a/6a"
put_template 15 "86/90/85"

color_foreground="3b/43/3a"
color_background="f1/f5/f0"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3b433a"
  put_template_custom Ph "f1f5f0"
  put_template_custom Pi "3b433a"
  put_template_custom Pj "dedbcb"
  put_template_custom Pk "3b433a"
  put_template_custom Pl "3b433a"
  put_template_custom Pm "f1f5f0"
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
