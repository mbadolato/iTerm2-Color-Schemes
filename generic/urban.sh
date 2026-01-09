#!/bin/sh
# urban

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
put_template 0  "33/30/3b"
put_template 1  "87/40/4f"
put_template 2  "74/93/4e"
put_template 3  "ae/83/5a"
put_template 4  "61/57/72"
put_template 5  "85/4b/64"
put_template 6  "62/54/64"
put_template 7  "c0/a7/9a"
put_template 8  "5c/58/65"
put_template 9  "87/40/4f"
put_template 10 "74/93/4e"
put_template 11 "ae/83/5a"
put_template 12 "61/57/72"
put_template 13 "85/4b/64"
put_template 14 "62/54/64"
put_template 15 "c0/a7/9a"

color_foreground="c0/a7/9a"
color_background="31/2e/39"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c0a79a"
  put_template_custom Ph "312e39"
  put_template_custom Pi "c0a79a"
  put_template_custom Pj "c0a79a"
  put_template_custom Pk "312e39"
  put_template_custom Pl "c0a79a"
  put_template_custom Pm "312e39"
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
