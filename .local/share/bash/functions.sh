# shellcheck shell=bash

__usage() {
  if (($1 < $2)); then
    printf 'Usage: %s %s\n' "${FUNCNAME[1]}" "$3"
    return 1
  fi
  return 0
}

__isnumber() {
  [[ $1 == ?([+-])+([0-9])?([.,]+([0-9])) ]]
}

count() { # Counts the number of characters in a string
  __usage $# 1 '<string>' || return 1
  printf '%d\n' "${#1}"
}

trim() { # Trims leading and trailing whitespace
  __usage $# 1 '<string>' || return 1
  : "${1#"${1%%[![:space:]]*}"}"
  : "${_%"${_##*[![:space:]]}"}"
  printf '%s\n' "$_"
}

rot13() { # Encodes/Decodes string in rot13
  __usage $# 1 '<string>' || return 1
  tr 'A-Za-z' 'N-ZA-Mn-za-m' <<< "$1"
}

tempconv() { # Converts Fahrenheit to Celsius and vice versa
  __usage $# 2 '<c | f> <degree>' || return 1
  if ! __isnumber "$2"; then
    printf 'The second argument must be a number.\n' >&2
    return 1
  fi
  case "$1" in
    [Ff]) printf '%d\u02DAC\n' "$((5 * ($2 - 32) / 9))"; return ;;
    [Cc]) printf '%d\u02DAF\n' "$(($2 * 9 / 5 + 32))"; return ;;
    *) __usage 0 1 '<c | f> <degree>' || return 1
  esac
}

rgb2hex() { # Converts rgb colour to hex
  __usage $# 3 '<red> <green> <blue>' || return 1
  printf '#%02x%02x%02x\n' "$1" "$2" "$3"
}

hex2rgb() { # Converts hex colour to rgb
  __usage $# 1 '<hex>' || return 1
  declare -i r g b
  ((r=16#${1:0:2},g=16#${1:2:2},b=16#${1:4:2}))
  printf '%s %s %s\n' $r $g $b
}

shuffle() { # Shuffles letters in string
  __usage $# 1 '<string>' || return 1
  perl -MList::Util=shuffle -F'' \
    -lane 'print shuffle @F' <<< "$1"
}

weather() { # Shows weather info from wttr.in
  __usage $# 1 '<place> [country]' || return 1
  curl -fsS4 "v2d.wttr.in/${1}+${2:-Greece}" | head -n -2
}

sri() { # Prints the SRI hash of a resource
  __usage $# 1 '<URL> [bits]' || return 1
  printf 'sha%d-%s\n' "${2:-384}" \
    "$(curl -Ss "$1" | shasum -ba "${2:-384}" - | xxd -r -p | base64)"
}

myip() { # What's my ip
   dig +short +tls A myip.opendns.com @resolver1.opendns.com
}

urlencode() { # Encodes string for url
  __usage $# 1 '<string>' || return 1
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
  __usage $# 1 '<string>' || return 1
  printf '%b\n' "${*//%/\\x}"
}

utf8decode() { # Decodes =?UTF-8?B?...?= string
  __usage $# 1 '<string>' || return 1
  [[ $* =~ ^=\?[Uu][Tt][Ff]-8\?[Bb]\?([^?]+)\?=$ ]]
  printf '%s\n' "$(base64 -d <<< "${BASH_REMATCH[1]}")"
}

iso2usb() { # Writes an iso to a usb device
  __usage $# 2 '<iso> <usb> [bs]' || return 1
  sudo dd if="$1" of="$2" status=progress bs="${3:-4M}" oflag=sync
}

# vim:fdm=syntax:fdl=0:
