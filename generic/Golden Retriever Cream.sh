#!/bin/sh
# Golden Retriever Cream

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
put_template 0  "6f/5b/47"
put_template 1  "df/6a/5b"
put_template 2  "70/ad/72"
put_template 3  "d7/9b/32"
put_template 4  "5b/8f/d9"
put_template 5  "c7/7d/bb"
put_template 6  "4f/bf/b3"
put_template 7  "a8/9b/8c"
put_template 8  "c3/b6/a6"
put_template 9  "e8/6f/7a"
put_template 10 "78/c9/8a"
put_template 11 "e2/ac/42"
put_template 12 "69/a8/ea"
put_template 13 "e2/a8/d9"
put_template 14 "61/ca/bb"
put_template 15 "ed/e3/d4"

color_foreground="3a/2f/24"
color_background="fa/f7/f2"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "3a2f24"
  put_template_custom Ph "faf7f2"
  put_template_custom Pi "8a735d"
  put_template_custom Pj "e8d9c4"
  put_template_custom Pk "3a2f24"
  put_template_custom Pl "c1945a"
  put_template_custom Pm "f1f1e5"
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
