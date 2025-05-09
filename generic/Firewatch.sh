#!/bin/sh
# Firewatch

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
put_template 0  "58/5f/6d"
put_template 1  "d9/53/60"
put_template 2  "5a/b9/77"
put_template 3  "df/b5/63"
put_template 4  "4d/89/c4"
put_template 5  "d5/51/19"
put_template 6  "44/a8/b6"
put_template 7  "e6/e5/ff"
put_template 8  "58/5f/6d"
put_template 9  "d9/53/60"
put_template 10 "5a/b9/77"
put_template 11 "df/b5/63"
put_template 12 "4c/89/c5"
put_template 13 "d5/51/19"
put_template 14 "44/a8/b6"
put_template 15 "e6/e5/ff"

color_foreground="9b/a2/b2"
color_background="1e/20/27"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "9ba2b2"
  put_template_custom Ph "1e2027"
  put_template_custom Pi "e6e5ff"
  put_template_custom Pj "2f363e"
  put_template_custom Pk "7d8fa4"
  put_template_custom Pl "f6f7ec"
  put_template_custom Pm "c4c5b5"
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
