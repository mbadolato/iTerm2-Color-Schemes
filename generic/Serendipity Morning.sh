#!/bin/sh
# Serendipity Morning

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
put_template 0  "cc/d0/dc"
put_template 1  "c2/5a/4d"
put_template 2  "2f/7a/ab"
put_template 3  "78/5f/d0"
put_template 4  "62/88/d8"
put_template 5  "62/9a/a5"
put_template 6  "e5/86/78"
put_template 7  "3f/43/63"
put_template 8  "50/55/75"
put_template 9  "c2/5a/4d"
put_template 10 "2f/7a/ab"
put_template 11 "78/5f/d0"
put_template 12 "62/88/d8"
put_template 13 "62/9a/a5"
put_template 14 "e5/86/78"
put_template 15 "3f/43/63"

color_foreground="3f/43/63"
color_background="f6/f7/fb"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3f4363"
  put_template_custom Ph "f6f7fb"
  put_template_custom Pi "3f4363"
  put_template_custom Pj "5a5670"
  put_template_custom Pk "7f83a3"
  put_template_custom Pl "6d7296"
  put_template_custom Pm "3f4363"
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
