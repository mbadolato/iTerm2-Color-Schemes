#!/bin/sh
# X Helsinki

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
put_template 0  "f8/fa/fe"
put_template 1  "1f/aa/9e"
put_template 2  "73/3d/9a"
put_template 3  "2e/70/ad"
put_template 4  "b5/5a/0f"
put_template 5  "3e/9d/21"
put_template 6  "bd/4c/3d"
put_template 7  "54/4d/40"
put_template 8  "b0/a9/99"
put_template 9  "00/9e/91"
put_template 10 "5a/1f/8a"
put_template 11 "0f/5b/a2"
put_template 12 "b2/3b/00"
put_template 13 "21/8c/00"
put_template 14 "b3/2e/1f"
put_template 15 "00/00/00"

color_foreground="54/4d/40"
color_background="f8/fa/fe"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "544d40"
  put_template_custom Ph "f8fafe"
  put_template_custom Pi "544d40"
  put_template_custom Pj "544d40"
  put_template_custom Pk "f8fafe"
  put_template_custom Pl "544d40"
  put_template_custom Pm "f8fafe"
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
