#!/usr/bin/env bash

# For iTerm schemes only
if [[ "$(uname -s)" != "Darwin" ]]; then
	echo "Fatal error: this script is for iTerm on macOS only." >&2
	exit 1
fi

# Parse arguments
VERBOSE=false
while getopts 'vh' OPT; do
	case $OPT in
	v)
		VERBOSE=true
		;;
	h)
		echo "Usage: $(basename "$0") [-h] [-v] [scheme ...] [file ...]"
		exit
		;;
	*)
		echo "Usage: $(basename "$0") [-h] [-v] [scheme ...] [file ...]"
		exit 128
		;;
	esac
done
shift $(($OPTIND - 1))

# Print help information if no arguments
if (($# == 0)); then
	echo "Usage: $(basename "$0") [-h] [-v] [scheme ...] [file ...]" >&2
	exit 2
fi

# Pretty print function
function echo_and_eval() {
	if $VERBOSE; then
		printf "%s" "$@" | awk \
			'BEGIN {
				RESET = "\033[0m";
				BOLD = "\033[1m";
				UNDERLINE = "\033[4m";
				UNDERLINEOFF = "\033[24m";
				RED = "\033[31m";
				GREEN = "\033[32m";
				YELLOW = "\033[33m";
				WHITE = "\033[37m";
				GRAY = "\033[90m";
				IDENTIFIER = "[_a-zA-Z][_a-zA-Z0-9]*";
				idx = 0;
				in_string = 0;
				double_quoted = 1;
				printf("%s$", BOLD WHITE);
			}
			{
				for (i = 1; i <= NF; ++i) {
					style = WHITE;
					post_style = WHITE;
					if (!in_string) {
						if ($i ~ /^-/)
							style = YELLOW;
						else if ($i == "sudo" && idx == 0) {
							style = UNDERLINE GREEN;
							post_style = UNDERLINEOFF WHITE;
						}
						else if ($i ~ "^" IDENTIFIER "+=" && idx == 0) {
							style = GRAY;
							'"if (\$i ~ \"^\" IDENTIFIER \"+=[\\\"']\") {"'
								in_string = 1;
								double_quoted = ($i ~ "^" IDENTIFIER "+=\"");
							}
						}
						else if ($i ~ /^[12&]?>>?/ || $i == "\\")
							style = RED;
						else {
							++idx;
							'"if (\$i ~ /^[\"']/) {"'
								in_string = 1;
								double_quoted = ($i ~ /^"/);
							}
							if (idx == 1)
								style = GREEN;
						}
					}
					if (in_string) {
						if (style == WHITE)
							style = "";
						post_style = "";
						'"if ((double_quoted && \$i ~ /\";?\$/ && \$i !~ /\\\\\";?\$/) || (!double_quoted && \$i ~ /';?\$/))"'
							in_string = 0;
					}
					if ($i ~ /;$/ || $i == "|" || $i == "||" || $i == "&&") {
						if (!in_string) {
							idx = 0;
							if ($i !~ /;$/)
								style = RED;
						}
					}
					if ($i ~ /;$/)
						printf(" %s%s%s;%s", style, substr($i, 1, length($i) - 1), (in_string ? WHITE : RED), post_style);
					else
						printf(" %s%s%s", style, $i, post_style);
					if ($i == "\\")
						printf("\n\t");
				}
			}
			END {
				printf("%s\n", RESET);
			}'
	fi
	eval "$@"
}

# Navigate to the root directory
TOOL_DIR="$(
	cd "$(dirname "$0")"
	pwd -L
)"
ROOT_DIR="$(dirname "$TOOL_DIR")"
cd "$ROOT_DIR"

# Download the default iTerm configuration file if not exists
if [[ ! -s "$HOME/Library/Preferences/com.googlecode.iterm2.plist" ]]; then
	echo "Downloading the default iTerm configuration file ..."
	echo_and_eval "curl -fL# -o \"\$HOME/Library/Preferences/com.googlecode.iterm2.plist\" \\
			https://github.com/gnachman/iTerm2/raw/master/plists/iTerm2.plist"
fi

# Create 'Custom Color Presets' entry if not exists
if ! /usr/libexec/PlistBuddy -c 'Print "Custom Color Presets"' \
	"$HOME/Library/Preferences/com.googlecode.iterm2.plist" &>/dev/null; then
	echo "Creating 'Custom Color Presets' entry ..."
	echo_and_eval "/usr/libexec/PlistBuddy \\
				-c 'Add \"Custom Color Presets\" dict' \\
				\"\$HOME/Library/Preferences/com.googlecode.iterm2.plist\""
fi

# Import color schemes for iTerm
count=0
for filename in "$@"; do
	count=$((count + 1))
	if (echo "$filename" | grep -qF '.itermcolors'); then
		filename="schemes/"$(basename "$filename")""
	fi
	if [[ ! -f "$filename" && -f "schemes/$filename.itermcolors" ]]; then
		filename="schemes/$filename.itermcolors"
	fi
	if [[ ! -f "$filename" ]]; then
		echo "File not found: \"$filename\". Skip." >&2
		continue
	elif ! (echo "$filename" | grep -qF '.itermcolors'); then
		echo "Invalid iTerm color scheme file: \"$filename\". Skip." >&2
		continue
	fi

	# Format the scheme name (capitalized)
	name="$(
		echo "$filename" |
			sed -E 's|.*/([^/]*)\.itermcolors|\1|g' |
			sed -E 's/([0-9a-zA-Z])_([0-9a-zA-Z])/\1 \2/g; s/([0-9a-zA-Z])-([0-9a-zA-Z])/\1 \2/g;'
	)"
	name=($name)
	name="${name[*]^}"
	name="$(
		echo "$name" |
			sed -E 's| In | in |g; s| Of | of |g; s| And | and |g; s| V([0-9]+)$| v\1|g'
	)"

	# Import the color scheme
	echo "Importing color scheme ($count/$#): $name (\"$filename\") ..."
	if /usr/libexec/PlistBuddy -c "Print \"Custom Color Presets:$name\"" \
		"$HOME/Library/Preferences/com.googlecode.iterm2.plist" &>/dev/null; then
		# If already installed
		# Delete first and reinstall
		echo_and_eval "/usr/libexec/PlistBuddy \\
				-c 'Delete \"Custom Color Presets:$name\"' \\
				-c 'Add \"Custom Color Presets:$name\" dict' \\
				-c 'Merge \"$filename\" \"Custom Color Presets:$name\"' \\
				\"\$HOME/Library/Preferences/com.googlecode.iterm2.plist\""
	else
		# If not installed
		# Install directly
		echo_and_eval "/usr/libexec/PlistBuddy \\
				-c 'Add \"Custom Color Presets:$name\" dict' \\
				-c 'Merge \"$filename\" \"Custom Color Presets:$name\"' \\
				\"\$HOME/Library/Preferences/com.googlecode.iterm2.plist\""
	fi
done
