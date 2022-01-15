#!/usr/bin/env bash

usage() {
    echo "Renames files from camera with date of file creation from EXIF"
    echo
    echo "Usage"
    echo -e "\t$0 [OPTIONS]"
    echo
    echo "Options"
    echo -e "\t-d\tdry run"
    echo -e "\t-n\tno description in resulting filename"
    echo -e "\t-t\tdo not touch already renamed files"
    echo -e "\t-h\thelp"
    echo
    exit 0
}

exif() {
    identify -format '%[EXIF:*]' $1
}

get_images_list2() {
    find . -type f -exec file {} \; | grep 'image' | sed -r 's/^([^:]*):.+image.*/\1/g'
}
get_images_list() {
    if [ -n "$DONT_TOUCH_RENAMED" ] && [ "$DONT_TOUCH_RENAMED" -eq "1" ]; then
        get_images_list2 | grep -v '\./[1-2][0-9]\{3,3\}[0-1][0-9][0-3][0-9]_[0-2][0-9][0-5][0-9][0-5][0-9]\.[a-zA-Z]\{1,\}'
    else
        get_images_list2
    fi
}


while getopts "dnth" OPTIONS; do
    case "$OPTIONS" in
        "d")
            DRY_RUN=1
            ;;
        "n")
            NO_DESCRIPTION=1
            ;;
        "t")
            DONT_TOUCH_RENAMED=1
            ;;
        "h")
            usage
            ;;
    esac
done

# For correctly work with filenames with spaces:
IFS=$(echo  -en "\n\b")

for i in $(get_images_list | sort | uniq); do
    FNAME=$(exif "$i" | grep 'exif:DateTimeOriginal' | sed -r -e 's/exif:DateTimeOriginal=(.+[0-9])/\1/g' -e 's/://g' -e 's/ /_/g')
    EXTEN=$(echo "$i" | sed -r 's/.+(\.[a-zA-Z]+)/\1/g')
    # Take description, if exists, from filename like "123 - descr.png" or "123-descr.png":
    DESCR=$(echo "$i" | grep ' \{0,1\}- \{0,1\}' | sed -r 's/.+[0-9]+ ?- ?(.+)\.[a-zA-Z]+/\1/g')

    if [ ! -n "$FNAME" ] || [ "$FNAME" == "" ]; then
        FNAME=$(exif "$i" | grep 'exif:DateTime' | sed -r -e 's/exif:DateTime=(.+[0-9])/\1/g' -e 's/://g' -e 's/ /_/g')
    fi
    if [ ! -n "$FNAME" ] || [ "$FNAME" == "" ]; then
        FNAME=$(stat --printf="%y" "$i" | sed -r -e 's/([0-9 :-])\.[0-9 +]+/\1/g' -e 's/[-:]//g' -e 's/ /_/g')
    fi
    if [ -n "$DESCR" ] && [ "$DESCR" != "" ] && [ ! -n "$NO_DESCRIPTION" ]; then
        FNAME="$FNAME - $DESCR"
    fi

    if [ -n "$DRY_RUN" ] && [ "$DRY_RUN" -eq 1 ]; then
        echo "$i -> $FNAME$EXTEN"
    else
        mv -v "$i" "$FNAME$EXTEN"
    fi
done

