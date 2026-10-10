#!/bin/sh
# Monster Mash

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
put_template 0  "b8/c9/ae"
put_template 1  "f0/95/79"
put_template 2  "9e/e5/66"
put_template 3  "e7/cf/52"
put_template 4  "86/c5/e8"
put_template 5  "bd/91/e8"
put_template 6  "72/d8/cc"
put_template 7  "f0/f5/d8"
put_template 8  "c1/cf/b8"
put_template 9  "f2/a2/89"
put_template 10 "aa/e8/78"
put_template 11 "ea/d5/67"
put_template 12 "95/cc/eb"
put_template 13 "c5/9e/eb"
put_template 14 "83/dd/d2"
put_template 15 "f2/f6/dd"

color_foreground="f0/f5/d8"
color_background="17/3b/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f0f5d8"
  put_template_custom Ph "173b0d"
  put_template_custom Pi "ead567"
  put_template_custom Pj "c1cfb8"
  put_template_custom Pk "8c9077"
  put_template_custom Pl "f2a289"
  put_template_custom Pm "173b0d"
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
