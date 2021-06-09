#!/bin/sh

host=$(echo "$HOSTNAME" | tr [:upper:] [:lower:])
machine=""
section=""

paclist="pac.list"
aurlist="aur.list"
[ -f "$paclist" ] && rm pac.list
[ -f "$aurlist" ] && rm aur.list
touch pac.list aur.list

sed -E 's/\s*#.*//g; s/^\s*//g; s/\s*$//g; /^$/d' spec.txt | \
while read line; do
    # replace this regex match with a non-bashism
    if [[ "$line" =~ ^:section ]]; then
        section=$(echo "$line" | sed -E 's/^:section\s+(\w+)$/\1/')
    elif [[ "$line" =~ ^:machine ]]; then
        machine=$(echo "$line" | sed -E 's/^:machine\s+(\w+)$/\1/')
    else
        [ "$machine" = "$host" -o "$machine" = "global" ] && \
        case $section in
            excludes)
                # rm -f $line
                echo -e "$machine\tdelete\t$line"
                ;;
            wants)
                echo "$line" >> $paclist
                ;;
            gitwants)
                echo "$line" >> "$aurlist"
                ;;
        esac
    fi
done
