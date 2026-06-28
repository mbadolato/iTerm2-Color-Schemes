#!/bin/sh
# Matcha Zen

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
put_template 0  "35/40/29"
put_template 1  "c2/45/2a"
put_template 2  "4e/8c/2e"
put_template 3  "92/70/00"
put_template 4  "2e/7c/78"
put_template 5  "7e/5b/a6"
put_template 6  "2a/85/85"
put_template 7  "56/66/4a"
put_template 8  "97/a8/87"
put_template 9  "c2/45/2a"
put_template 10 "4e/8c/2e"
put_template 11 "b0/5a/1e"
put_template 12 "2e/7c/78"
put_template 13 "7e/5b/a6"
put_template 14 "2a/85/85"
put_template 15 "35/40/29"

color_foreground="35/40/29"
color_background="f5/f7/ea"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "354029"
  put_template_custom Ph "f5f7ea"
  put_template_custom Pi "354029"
  put_template_custom Pj "dde7cc"
  put_template_custom Pk "a8aa9d"
  put_template_custom Pl "4e8c2e"
  put_template_custom Pm "f5f7ea"
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
