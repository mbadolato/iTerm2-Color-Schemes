#!/bin/sh
# tokyonight-storm

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
put_template 0  "1d/20/2f"
put_template 1  "f7/76/8e"
put_template 2  "9e/ce/6a"
put_template 3  "e0/af/68"
put_template 4  "7a/a2/f7"
put_template 5  "bb/9a/f7"
put_template 6  "7d/cf/ff"
put_template 7  "a9/b1/d6"
put_template 8  "41/48/68"
put_template 9  "f7/76/8e"
put_template 10 "9e/ce/6a"
put_template 11 "e0/af/68"
put_template 12 "7a/a2/f7"
put_template 13 "bb/9a/f7"
put_template 14 "7d/cf/ff"
put_template 15 "c0/ca/f5"

color_foreground="c0/ca/f5"
color_background="24/28/3b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c0caf5"
  put_template_custom Ph "24283b"
  put_template_custom Pi "eeeeee"
  put_template_custom Pj "364a82"
  put_template_custom Pk "c0caf5"
  put_template_custom Pl "c0caf5"
  put_template_custom Pm "1d202f"
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
