#!/bin/sh

targetSection="$1"

host=$(echo "$HOSTNAME" | tr [:upper:] [:lower:])
machine=""
section=""

paclist="pac.list"
if [ "$targetSection" = "wants" ]; then
    [ -f "$paclist" ] && rm "$paclist"
    touch "$paclist"
fi

aurlist="aur.list"
if [ "$targetSection" = "gitwants" ]; then
    [ -f "$aurlist" ] && rm "$aurlist"
    touch "$aurlist"
fi

applyState() {
    [ "$machine" = "$host" -o "$machine" = "global" ] || return 0

    case $section in
        hostrenames)
            echo "mv" "$(echo "$1" | sed -E "s/^(.*)$/\1-${host}/")" "$1"
            mv "$(echo "$1" | sed -E "s/^(.*)$/\1-${host}/")" "$1"
            ;;
        excludes)
            echo "rm -f \"$1\""
            rm -f $1
            ;;
        copiesdir)
            sourcepath=$(echo "$1" | cut -d' ' -f 1)
            destperm=$(echo "$1" | cut -d' ' -f 2)
            find $sourcepath -type f -exec install -Dm $destperm "{}" "$HOME/{}" \;
            ;;
        wants)
            echo "$1" >> "$paclist"
            ;;
        gitwants)
            echo "$1" >> "$aurlist"
            ;;
    esac
}

# spec.txt parse loop
sed -E 's/\s*#.*//g; s/^\s*//g; s/\s*$//g; /^$/d' spec.txt | \
while read line; do
    # replace this regex match with a non-bashism
    if [[ "$line" =~ ^:section ]]; then
        section=$(echo "$line" | sed -E 's/^:section\s+(\w+)$/\1/')
    elif [[ "$line" =~ ^:machine ]]; then
        machine=$(echo "$line" | sed -E 's/^:machine\s+(\w+)$/\1/')
    else
        [ "$section" = "targetSection" ] && applyState "$line"
    fi
done
