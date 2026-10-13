#!/bin/sh
# Kashmir Nights

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
put_template 0  "b4/a2/9a"
put_template 1  "dc/80/5e"
put_template 2  "b6/b1/8a"
put_template 3  "e6/b4/6a"
put_template 4  "9c/ac/c1"
put_template 5  "b5/a0/b7"
put_template 6  "a6/b6/ad"
put_template 7  "f4/df/c9"
put_template 8  "c9/b8/a9"
put_template 9  "f0/9b/72"
put_template 10 "cb/c5/9d"
put_template 11 "f7/cc/82"
put_template 12 "b5/c2/d2"
put_template 13 "ce/b5/d0"
put_template 14 "bc/d1/c1"
put_template 15 "ff/f0/dd"

color_foreground="f4/df/c9"
color_background="29/17/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f4dfc9"
  put_template_custom Ph "291714"
  put_template_custom Pi "fff5e6"
  put_template_custom Pj "604136"
  put_template_custom Pk "fff9ed"
  put_template_custom Pl "f1bb72"
  put_template_custom Pm "291714"
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
