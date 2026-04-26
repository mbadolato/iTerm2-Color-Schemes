#!/bin/sh
# Claude Dark

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
put_template 0  "88/86/81"
put_template 1  "d4/75/63"
put_template 2  "9a/ca/86"
put_template 3  "e8/c9/6b"
put_template 4  "6a/9b/cc"
put_template 5  "9b/87/f5"
put_template 6  "3c/be/8c"
put_template 7  "e2/e1/da"
put_template 8  "a6/a5/9b"
put_template 9  "f4/a9/a9"
put_template 10 "a8/d1/66"
put_template 11 "fa/b3/19"
put_template 12 "9f/c5/f4"
put_template 13 "f3/aa/c5"
put_template 14 "79/d7/b3"
put_template 15 "ef/ee/eb"

color_foreground="e5/e4/e1"
color_background="26/26/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e5e4e1"
  put_template_custom Ph "262624"
  put_template_custom Pi "e5e4e1"
  put_template_custom Pj "363634"
  put_template_custom Pk "e5e4e1"
  put_template_custom Pl "d97757"
  put_template_custom Pm "262624"
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
