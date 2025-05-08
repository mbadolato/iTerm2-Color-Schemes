#!/bin/sh
# terafox

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
put_template 0  "2f/32/39"
put_template 1  "e8/5c/51"
put_template 2  "7a/a4/a1"
put_template 3  "fd/a4/7f"
put_template 4  "5a/93/aa"
put_template 5  "ad/5c/7c"
put_template 6  "a1/cd/d8"
put_template 7  "eb/eb/eb"
put_template 8  "4e/51/57"
put_template 9  "eb/74/6b"
put_template 10 "8e/b2/af"
put_template 11 "fd/b2/92"
put_template 12 "73/a3/b7"
put_template 13 "b9/74/90"
put_template 14 "af/d4/de"
put_template 15 "ee/ee/ee"

color_foreground="e6/ea/ea"
color_background="15/25/28"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6eaea"
  put_template_custom Ph "152528"
  put_template_custom Pi "e6eaea"
  put_template_custom Pj "293e40"
  put_template_custom Pk "e6eaea"
  put_template_custom Pl "e6eaea"
  put_template_custom Pm "152528"
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
