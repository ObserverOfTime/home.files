__usage() {
  if (($1 < $2)); then
    printf 'Usage: %s %s\n' "${FUNCNAME[1]}" "$3"
    return 0
  fi
  return 1
}

__isnumber() {
  [[ $1 == ?([+-])+([0-9])?([.,]+([0-9])) ]]
}

count() { # Counts the number of characters in a string
  __usage $# 1 '<string>' && return 1
  printf '%d\n' "${#1}"
}

trim() { # Trims leading and trailing whitespace
  __usage $# 1 '<string>' && return 1
  : "${1#"${1%%[![:space:]]*}"}"
  : "${_%"${_##*[![:space:]]}"}"
  printf '%s\n' "$_"
}

dtl() { # Deletes the top lines of a file
  __usage $# 2 '<file> <number>' && return 1
  (($2 == 0)) && return
  declare -a file
  mapfile -O "$2" -tn 0 file < "$1"
  printf '%s\n' "${file[@]}" > "$1"
}

dbl() { # Deletes the bottom lines of a file
  __usage $# 2 '<file> <number>' && return 1
  (($2 == 0)) && return
  declare -a file
  mapfile -tn 0 file < "$1"
  printf '%s\n' "${file[@]:0:$((${#file[@]}-$2))}" > "$1"
}

rot13() { # Encodes/Decodes string in rot13
  __usage $# 1 '<string>' && return 1
  tr 'A-Za-z' 'N-ZA-Mn-za-m' <<< "$1"
}

pictshare() { # Uploads image to pictshare
  __usage $# 1 '<file>' && return 1
  curl -sSF "file=@$1" \
    https://pictshare.net/api/upload.php | \
    awk -F'"' '{gsub(/\\/,""); print $12}'
}

transh() { # Uploads file to transfer.sh
  __usage $# 1 '<file> [max days] [name]' && return 1
  declare file
  if [ -n "${3// }" ]; then file="${3// /_}"
  else : "${1%/}"; : "${_##*/}"; file="${_// /%20}"; fi
  curl -Ss --upload-file "$1" -H "Max-Days: ${2:1}" \
    "https://transfer.sh/$file" && printf '\n'
}

svgmin() { # Minifies and formats svg into a data URI
  __usage $# 2 '< -i FILE | -s STRING >' && return 1
  declare plugins tmpfile
  plugins="$(svgo --show-plugins | awk '
    BEGIN { printf "{" }
    /cleanup|remove/ { printf c $2; c="," }
    END   { printf "}" }')"
  tmpfile="$(mktemp svgmin.XXXXXXXX)"
  svgo --enable="$plugins" "$@" --datauri=encoded -o "$tmpfile"
  printf "'data:image/svg+xml;UTF8,%s'\\n" "$(<"$tmpfile")"
  rm "$tmpfile"
}

tempconv() { # Converts Fahrenheit to Celsius and vice versa
  __usage $# 2 '<c | f> <degree>' && return 1
  if ! __isnumber "$2"; then
    printf 'The second argument must be a number.\n' >&2
    return 1
  fi
  case "$1" in
    [Ff]) printf '%d \u02DAC\n' "$((($2 - 32) * 5 / 9))"; return ;;
    [Cc]) printf '%d \u02DAF\n' "$(($2 * 9 / 5 + 32))"; return ;;
    *) __usage 0 1 '<c | f> <degree>' && return 1
  esac
}

rgb2hex() { # Converts rgb colour to hex
  __usage $# 3 '<red> <green> <blue>' && return 1
  printf '#%02x%02x%02x\n' "$1" "$2" "$3"
}

hex2rgb() { # Converts hex colour to rgb
  __usage $# 1 '<hex>' && return 1
  declare r g b
  ((r="16#${1:0:2}",g="16#${1:2:2}",b="16#${1:4:2}"))
  printf '%s\n' "$r $g $b"
}

shuffle() { # Shuffles letters in string
  __usage $# 1 '<string>' && return 1
  perl -MList::Util=shuffle -F'' \
    -lane 'print shuffle @F' <<< "$1"
}

cht() { # Searches cht.sh cheatsheet
  __usage $# 2 '<language> <query>' && return 1
  : "${*:2}"; curl -sS4 "cht.sh/$1/${_// /+})?Q"
}

weather() { # Shows weather info from wttr.in
  __usage $# 1 '<place> [country]' && return 1
  curl -sS4 "wttr.in/~${1}+${2:-Greece}" | head -n -2
}

sri() { # Prints the SRI hash of a resource
  __usage $# 1 '<URL> [bits]' && return 1
  printf 'sha%d-%s\n' "${2:-384}" \
    "$(curl -Ss "$1" | shasum -ba "${2:-384}" - | xxd -r -p | base64)"
}

myip() { # What's my ip
   drill myip.opendns.com @resolver1.opendns.com | awk '/^myip/{print $NF}'
}

urlencode() { # Encodes string for url
  __usage $# 1 '<string>' && return 1
  declare LANG=C len=${#1} char i
  for ((i = 0; i < len; ++i)); do
    char="${1:i:1}"
    case $char in
      [a-zA-Z0-9.~_-]) printf '%s' "$char" ;;
      *) printf '%%%02X' "'$char" ;;
    esac
  done
}

urldecode() { # Decodes urlencoded string
  __usage $# 1 '<string>' && return 1
  printf '%b\n' "${*//%/\\x}"
}

utf8decode() { # Decodes =?UTF-8?B?...?= string
  __usage $# 1 '<string>' && return 1
  [[ $* =~ ^=\?[Uu][Tt][Ff]-8\?[Bb]\?([^?]+)\?=$ ]]
  printf '%s\n' "$(base64 -d <<< "${BASH_REMATCH[1]}")"
}

pwned() { # Checks if a password has been compromised
  __usage $# 1 '<password>' && return 1
  declare pass results tmp
  pass="$(printf '%s' "$1" | sha1sum | cut -d ' ' -f1)"
  readarray -t results < <(curl -Ss \
    https://api.pwnedpasswords.com/range/"${pass:0:5}")
  for tmp in "${results[@]}"; do
    [ "${tmp%:*}" != "${pass^^}" ] || printf '%s\n' "$tmp"
  done
}

iso2usb() { # Writes an iso to a usb device
  __usage $# 2 '<iso> <usb> [bs]' && return 1
  sudo dd if="$1" of="$2" status=progress bs="${3:-4M}" oflag=sync
}

random() {  # Prints a random number up to a limit
  __usage $# 1 '<limit>' && return 1
  printf '%s\n' "$((RANDOM % $1 + 1))"
}

# vim:fdm=syntax:fdl=0:
