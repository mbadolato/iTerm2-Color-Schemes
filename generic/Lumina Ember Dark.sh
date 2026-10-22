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
put_template 0  "21/1e/1a"
put_template 1  "d1/63/5b"
put_template 2  "90/d6/b4"
put_template 3  "e4/d8/74"
put_template 4  "78/bb/ea"
put_template 5  "e5/a7/df"
put_template 6  "77/cf/d9"
put_template 7  "c0/b8/ab"
put_template 8  "97/8b/7e"
put_template 9  "dd/86/7e"
put_template 10 "a3/f2/cc"
put_template 11 "f7/eb/89"
put_template 12 "99/d4/ff"
put_template 13 "ff/c1/f9"
put_template 14 "90/e9/f4"
put_template 15 "e0/d8/cb"

color_foreground="e0/d8/cb"
color_background="1c/19/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0d8cb"
  put_template_custom Ph "1c1916"
  put_template_custom Pi "e0d8cb"
  put_template_custom Pj "4e3929"
  put_template_custom Pk "e0d8cb"
  put_template_custom Pl "e0d8cb"
  put_template_custom Pm "1c1916"
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
