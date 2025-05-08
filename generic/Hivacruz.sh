#!/bin/sh
# Hivacruz

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
put_template 0  "20/27/46"
put_template 1  "c9/49/22"
put_template 2  "ac/97/39"
put_template 3  "c0/8b/30"
put_template 4  "3d/8f/d1"
put_template 5  "66/79/cc"
put_template 6  "22/a2/c9"
put_template 7  "97/9d/b4"
put_template 8  "6b/73/94"
put_template 9  "c7/6b/29"
put_template 10 "73/ad/43"
put_template 11 "5e/66/87"
put_template 12 "89/8e/a4"
put_template 13 "df/e2/f1"
put_template 14 "9c/63/7a"
put_template 15 "f5/f7/ff"

color_foreground="ed/e4/e4"
color_background="13/26/38"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ede4e4"
  put_template_custom Ph "132638"
  put_template_custom Pi "979db4"
  put_template_custom Pj "5e6687"
  put_template_custom Pk "979db4"
  put_template_custom Pl "979db4"
  put_template_custom Pm "202746"
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
