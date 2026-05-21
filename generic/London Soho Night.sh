#!/bin/sh
# London Soho Night

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
put_template 0  "2a/22/1a"
put_template 1  "d4/57/4a"
put_template 2  "8f/ae/5e"
put_template 3  "e8/b0/4a"
put_template 4  "6a/8f/b5"
put_template 5  "d9/6a/a5"
put_template 6  "9a/b8/a8"
put_template 7  "eb/e0/c8"
put_template 8  "6b/5a/48"
put_template 9  "e8/77/65"
put_template 10 "aa/c8/74"
put_template 11 "f4/c5/60"
put_template 12 "88/a8/c8"
put_template 13 "ed/85/b8"
put_template 14 "b8/ce/bd"
put_template 15 "f8/ee/d2"

color_foreground="eb/e0/c8"
color_background="1a/16/12"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ebe0c8"
  put_template_custom Ph "1a1612"
  put_template_custom Pi "ebe0c8"
  put_template_custom Pj "3a2f24"
  put_template_custom Pk "ebe0c8"
  put_template_custom Pl "ff5db1"
  put_template_custom Pm "1a1612"
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
