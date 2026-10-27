#!/bin/sh
# Lumina Ember Dark

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
put_template 0  "1c/1a/15"
put_template 1  "cb/78/70"
put_template 2  "a9/cc/97"
put_template 3  "e5/cc/88"
put_template 4  "94/be/dc"
put_template 5  "d7/a2/c6"
put_template 6  "91/c7/cd"
put_template 7  "c4/bd/b0"
put_template 8  "8e/85/77"
put_template 9  "da/98/90"
put_template 10 "c5/e5/b5"
put_template 11 "ff/e6/a2"
put_template 12 "b0/d7/f4"
put_template 13 "f0/bc/df"
put_template 14 "aa/e1/e7"
put_template 15 "e4/dd/d0"

color_foreground="e4/dd/d0"
color_background="17/15/11"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e4ddd0"
  put_template_custom Ph "171511"
  put_template_custom Pi "e4ddd0"
  put_template_custom Pj "46342a"
  put_template_custom Pk "e4ddd0"
  put_template_custom Pl "e4ddd0"
  put_template_custom Pm "171511"
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
