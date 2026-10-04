#!/bin/sh
# Sun Bleached

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
put_template 0  "4a/40/38"
put_template 1  "9e/49/35"
put_template 2  "4b/69/4d"
put_template 3  "72/5a/1c"
put_template 4  "3a/63/78"
put_template 5  "76/54/6e"
put_template 6  "33/65/6a"
put_template 7  "59/4b/40"
put_template 8  "65/57/4d"
put_template 9  "90/4b/37"
put_template 10 "50/69/50"
put_template 11 "72/5c/23"
put_template 12 "42/66/78"
put_template 13 "77/5a/70"
put_template 14 "3a/66/6a"
put_template 15 "30/29/25"

color_foreground="4a/38/2f"
color_background="f0/df/c3"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "4a382f"
  put_template_custom Ph "f0dfc3"
  put_template_custom Pi "8b4b38"
  put_template_custom Pj "dfcbaa"
  put_template_custom Pk "2e2825"
  put_template_custom Pl "b75b3f"
  put_template_custom Pm "f0dfc3"
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
