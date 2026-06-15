#!/bin/sh
# Catppuccin Latte

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
put_template 0  "bc/c0/cc"
put_template 1  "d2/0f/39"
put_template 2  "40/a0/2b"
put_template 3  "df/8e/1d"
put_template 4  "1e/66/f5"
put_template 5  "ea/76/cb"
put_template 6  "17/92/99"
put_template 7  "5c/5f/77"
put_template 8  "ac/b0/be"
put_template 9  "e7/10/3f"
put_template 10 "46/b0/2f"
put_template 11 "e4/99/31"
put_template 12 "38/78/f6"
put_template 13 "ef/95/d7"
put_template 14 "19/a1/a8"
put_template 15 "6c/6f/85"

color_foreground="4c/4f/69"
color_background="ef/f1/f5"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "4c4f69"
  put_template_custom Ph "eff1f5"
  put_template_custom Pi "4c4f69"
  put_template_custom Pj "dc8a78"
  put_template_custom Pk "eff1f5"
  put_template_custom Pl "dc8a78"
  put_template_custom Pm "eff1f5"
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
