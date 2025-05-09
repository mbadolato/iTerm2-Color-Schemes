#!/bin/sh
# Later This Evening

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
put_template 0  "2b/2b/2b"
put_template 1  "d4/5a/60"
put_template 2  "af/ba/67"
put_template 3  "e5/d2/89"
put_template 4  "a0/ba/d6"
put_template 5  "c0/92/d6"
put_template 6  "91/bf/b7"
put_template 7  "3c/3d/3d"
put_template 8  "45/47/47"
put_template 9  "d3/23/2f"
put_template 10 "aa/bb/39"
put_template 11 "e5/be/39"
put_template 12 "66/99/d6"
put_template 13 "ab/53/d6"
put_template 14 "5f/c0/ae"
put_template 15 "c1/c2/c2"

color_foreground="95/95/95"
color_background="22/22/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "959595"
  put_template_custom Ph "222222"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "424242"
  put_template_custom Pk "959595"
  put_template_custom Pl "424242"
  put_template_custom Pm "959595"
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
