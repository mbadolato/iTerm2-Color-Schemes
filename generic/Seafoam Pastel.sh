#!/bin/sh
# Seafoam Pastel

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
put_template 0  "75/75/75"
put_template 1  "82/5d/4d"
put_template 2  "72/8c/62"
put_template 3  "ad/a1/6d"
put_template 4  "4d/7b/82"
put_template 5  "8a/72/67"
put_template 6  "72/94/94"
put_template 7  "e0/e0/e0"
put_template 8  "8a/8a/8a"
put_template 9  "cf/93/7a"
put_template 10 "98/d9/aa"
put_template 11 "fa/e7/9d"
put_template 12 "7a/c3/cf"
put_template 13 "d6/b2/a1"
put_template 14 "ad/e0/e0"
put_template 15 "e0/e0/e0"

color_foreground="d4/e7/d4"
color_background="24/34/35"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d4e7d4"
  put_template_custom Ph "243435"
  put_template_custom Pi "648890"
  put_template_custom Pj "ffffff"
  put_template_custom Pk "9e8b13"
  put_template_custom Pl "57647a"
  put_template_custom Pm "323232"
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
