#!/bin/sh

host=$(echo "$HOSTNAME" | tr [:upper:] [:lower:])
machine=""
section=""

paclist="pac.list"
aurlist="aur.list"
# It's a good idea to empty these before we regenerate them.
[ -f "$paclist" ] && rm pac.list
[ -f "$aurlist" ] && rm aur.list
touch pac.list aur.list

applyState() {
    [ "$machine" = "$host" -o "$machine" = "global" ] || return 0

    case $section in
        hostrenames)
            echo "mv" "$(echo "$1" | sed -E "s/^(.*)$/\1-${host}/")" "$1"
            # mv "$(echo "$1" | sed -E "s/^(.*)$/\1-${host}/")" "$1"
            ;;
        excludes)
            echo "rm -f \"$1\""
            # rm -f "$1"
            ;;
        copies)
            echo "install -Dm 644 -t ~/.config/ $1"
            # install -Dm 644 -t ~/.config/ $1
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
        applyState "$line"
    fi
done

cat "$paclist" | sudo pacman -S --needed -

mkdir -p ~/aur
cat "$aurlist" | ./aur.sh -i -
