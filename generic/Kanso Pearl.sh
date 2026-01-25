#!/bin/sh
# Kanso Pearl

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
put_template 0  "22/26/2d"
put_template 1  "c8/40/53"
put_template 2  "6f/89/4e"
put_template 3  "77/71/3f"
put_template 4  "4d/69/9b"
put_template 5  "b3/5b/79"
put_template 6  "59/7b/75"
put_template 7  "54/54/64"
put_template 8  "6d/6f/6e"
put_template 9  "d7/47/4b"
put_template 10 "6e/91/5f"
put_template 11 "83/6f/4a"
put_template 12 "66/93/bf"
put_template 13 "62/4c/83"
put_template 14 "5e/85/7a"
put_template 15 "43/43/6c"

color_foreground="22/26/2d"
color_background="f2/f1/ef"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "22262d"
  put_template_custom Ph "f2f1ef"
  put_template_custom Pi "22262d"
  put_template_custom Pj "e2e1df"
  put_template_custom Pk "22262d"
  put_template_custom Pl "22262d"
  put_template_custom Pm "f2f1ef"
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
