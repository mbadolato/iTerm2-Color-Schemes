#!/bin/sh
# Karma Light Dimmed

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
put_template 0  "1c/1f/24"
put_template 1  "e0/7a/90"
put_template 2  "4a/9a/4c"
put_template 3  "d4/9a/26"
put_template 4  "66/88/b8"
put_template 5  "7c/5a/b0"
put_template 6  "66/88/b8"
put_template 7  "5a/58/60"
put_template 8  "99/99/99"
put_template 9  "e0/7a/90"
put_template 10 "4a/9a/4c"
put_template 11 "e0/a0/40"
put_template 12 "66/88/b8"
put_template 13 "96/76/d0"
put_template 14 "66/88/b8"
put_template 15 "1c/1f/24"

color_foreground="1c/1f/24"
color_background="f5/f3/f7"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1c1f24"
  put_template_custom Ph "f5f3f7"
  put_template_custom Pi "1c1f24"
  put_template_custom Pj "ddd8e2"
  put_template_custom Pk "1c1f24"
  put_template_custom Pl "9676d0"
  put_template_custom Pm "f5f3f7"
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
