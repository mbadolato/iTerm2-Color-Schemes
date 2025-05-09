#!/bin/sh
# Cobalt Neon

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
put_template 0  "14/26/31"
put_template 1  "ff/23/20"
put_template 2  "3b/a5/ff"
put_template 3  "e9/e7/5c"
put_template 4  "8f/f5/86"
put_template 5  "78/1a/a0"
put_template 6  "8f/f5/86"
put_template 7  "ba/46/b2"
put_template 8  "ff/f6/88"
put_template 9  "d4/31/2e"
put_template 10 "8f/f5/86"
put_template 11 "e9/f0/6d"
put_template 12 "3c/7d/d2"
put_template 13 "82/30/a7"
put_template 14 "6c/bc/67"
put_template 15 "8f/f5/86"

color_foreground="8f/f5/86"
color_background="14/28/38"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "8ff586"
  put_template_custom Ph "142838"
  put_template_custom Pi "248b70"
  put_template_custom Pj "094fb1"
  put_template_custom Pk "8ff586"
  put_template_custom Pl "c4206f"
  put_template_custom Pm "8ff586"
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
