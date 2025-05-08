#!/bin/sh
# SleepyHollow

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
put_template 0  "57/21/00"
put_template 1  "ba/39/34"
put_template 2  "91/77/3f"
put_template 3  "b5/56/00"
put_template 4  "5f/63/b4"
put_template 5  "a1/7c/7b"
put_template 6  "8f/ae/a9"
put_template 7  "af/9a/91"
put_template 8  "4e/4b/61"
put_template 9  "d9/44/3f"
put_template 10 "d6/b0/4e"
put_template 11 "f6/68/13"
put_template 12 "80/86/ef"
put_template 13 "e2/c2/bb"
put_template 14 "a4/dc/e7"
put_template 15 "d2/c7/a9"

color_foreground="af/9a/91"
color_background="12/12/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "af9a91"
  put_template_custom Ph "121214"
  put_template_custom Pi "af9a92"
  put_template_custom Pj "575256"
  put_template_custom Pk "d2c7a9"
  put_template_custom Pl "af9a91"
  put_template_custom Pm "391a02"
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
