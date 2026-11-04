#!/bin/sh
# Edge Light

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
put_template 0  "fa/fa/fa"
put_template 1  "d0/58/58"
put_template 2  "60/8e/32"
put_template 3  "be/7e/05"
put_template 4  "50/79/be"
put_template 5  "b0/5c/cc"
put_template 6  "3a/8b/84"
put_template 7  "87/90/a0"
put_template 8  "af/b8/c2"
put_template 9  "e1/73/73"
put_template 10 "76/af/6f"
put_template 11 "de/b9/74"
put_template 12 "69/96/e0"
put_template 13 "bf/75/d6"
put_template 14 "5d/bb/c1"
put_template 15 "7e/86/9b"

color_foreground="4b/50/5b"
color_background="fa/fa/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "4b505b"
  put_template_custom Ph "fafafa"
  put_template_custom Pi "4b505b"
  put_template_custom Pj "e3eaf6"
  put_template_custom Pk "45505b"
  put_template_custom Pl "3a8b84"
  put_template_custom Pm "fafafa"
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
