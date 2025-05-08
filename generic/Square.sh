#!/bin/sh
# Square

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
put_template 0  "05/05/05"
put_template 1  "e9/89/7c"
put_template 2  "b6/37/7d"
put_template 3  "ec/eb/be"
put_template 4  "a9/cd/eb"
put_template 5  "75/50/7b"
put_template 6  "c9/ca/ec"
put_template 7  "f2/f2/f2"
put_template 8  "14/14/14"
put_template 9  "f9/92/86"
put_template 10 "c3/f7/86"
put_template 11 "fc/fb/cc"
put_template 12 "b6/de/fb"
put_template 13 "ad/7f/a8"
put_template 14 "d7/d9/fc"
put_template 15 "e2/e2/e2"

color_foreground="ac/ac/ab"
color_background="1a/1a/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "acacab"
  put_template_custom Ph "1a1a1a"
  put_template_custom Pi "e5e5e5"
  put_template_custom Pj "4d4d4d"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "fcfbcc"
  put_template_custom Pm "000000"
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
