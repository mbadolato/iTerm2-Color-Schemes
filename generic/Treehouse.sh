#!/bin/sh
# Treehouse

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
put_template 0  "32/13/00"
put_template 1  "b2/27/0e"
put_template 2  "44/a9/00"
put_template 3  "aa/82/0c"
put_template 4  "58/85/9a"
put_template 5  "97/36/3d"
put_template 6  "b2/5a/1e"
put_template 7  "78/6b/53"
put_template 8  "43/36/26"
put_template 9  "ed/5d/20"
put_template 10 "55/f2/38"
put_template 11 "f2/b7/32"
put_template 12 "85/cf/ed"
put_template 13 "e1/4c/5a"
put_template 14 "f0/7d/14"
put_template 15 "ff/c8/00"

color_foreground="78/6b/53"
color_background="19/19/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "786b53"
  put_template_custom Ph "191919"
  put_template_custom Pi "fac800"
  put_template_custom Pj "786b53"
  put_template_custom Pk "fac800"
  put_template_custom Pl "fac814"
  put_template_custom Pm "191919"
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
