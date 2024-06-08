#!/usr/bin/env bash
set -e

get_version() {
    echo $1 | awk 'match($0, /(profile|system)-([0-9]+)-link/, m){print m[2]}'
}

get_prev() {
    base_path=$1
    type=$2
    current="$(get_version $3)"
    #find /home/lukas/.local/state/nix/profiles/profile-*-link  -printf "%f\n" | awk 'match($0, /(profile|system)-([0-9]+)-link/, m){print m[2]}' | sort -n | grep 37 -B 1 | grep -v 37
    suffix='-*-link'
    f_name="$base_path$type$suffix"
    #echo "$f_name"
    #find $f_name -printf "%f\n"
    echo $(find $f_name -printf "%f\n" | awk 'match($0, /(profile|system)-([0-9]+)-link/, m){print m[2]}' | sort -n | grep "$current" -B 1 | grep -v "$current")
}

do_diff()
{
    base_path=$1
    type=$2
    current=$3
    prev=$(get_prev $1 $2 $3)
    from_="${base_path}${type}-${prev}-link"
    to_="$base_path$current"
    echo "$from_ -> $to_"
    nix store diff-closures "$from_" "$to_" 
}

p=$(readlink "$(readlink ~/.nix-profile)")
s=$(readlink /nix/var/nix/profiles/system)

#p2=$(get_prev "${HOME}/.local/state/nix/profiles/" "profile" "$p")
#s2=$(get_prev "/nix/var/nix/profiles/" "system" "$s")
#echo "$p - $p2"
#echo "$s - $s2"

echo "profile"
do_diff "${HOME}/.local/state/nix/profiles/" "profile" "$p"

echo ""
echo "system"
do_diff "/nix/var/nix/profiles/" "system" "$s"
