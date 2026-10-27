#!/bin/sh
# Lumina Quartz Dark

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
put_template 0  "1a/1c/1e"
put_template 1  "c5/7c/74"
put_template 2  "9d/d7/b7"
put_template 3  "df/cf/b0"
put_template 4  "b6/ce/ed"
put_template 5  "e4/bd/df"
put_template 6  "a8/d5/db"
put_template 7  "ac/b0/b3"
put_template 8  "86/8b/90"
put_template 9  "d5/9a/93"
put_template 10 "c2/ed/d5"
put_template 11 "ff/e5/b1"
put_template 12 "d6/e8/ff"
put_template 13 "ff/d7/fa"
put_template 14 "c1/ef/f6"
put_template 15 "cc/d0/d3"

color_foreground="cc/d0/d3"
color_background="16/17/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ccd0d3"
  put_template_custom Ph "161719"
  put_template_custom Pi "ccd0d3"
  put_template_custom Pj "44474a"
  put_template_custom Pk "ccd0d3"
  put_template_custom Pl "ccd0d3"
  put_template_custom Pm "161719"
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
