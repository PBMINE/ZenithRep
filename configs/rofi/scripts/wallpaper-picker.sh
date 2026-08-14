#!/usr/bin/env bash

WALLPAPER_DIR="/home/pbmine/Pictures/wallpaper"
CACHE_DIR="/home/pbmine/.cache/wallpaper-picker/thumbs"
THUMB_SIZE="84x84"

ROFI_THEME="/home/pbmine/.config/rofi/wallpaper.rasi"

mkdir -p "$CACHE_DIR"


gen_thumb() {
    local src="$1"
    local thumb="$CACHE_DIR/$(echo "$src" | md5sum | cut -d' ' -f1).jpg"

    if [[ ! -f "$thumb" ]]; then
        magick "$src" \
            -thumbnail "${THUMB_SIZE}^" \
            -gravity center \
            -extent "$THUMB_SIZE" \
            "$thumb" 2>/dev/null
    fi

    echo "$thumb"
}


detect_mode() {
    local name

    name=$(basename "$1")
    name="${name%.*}"
    name="${name,,}"

    name="${name/#s[0-4]_}"
    name="${name/%_s[0-4]}"
    name="${name/_s[0-4]_/_}"

    if [[ "$name" == white_* || "$name" == *_white ]]; then
        echo "light"
    else
        echo "dark"
    fi
}


detect_index() {
    local name

    name=$(basename "$1")
    name="${name%.*}"
    name="${name,,}"

    if [[ "$name" =~ (^|_)s([0-4])($|_) ]]; then
        echo "${BASH_REMATCH[2]}"
    else
        echo "0"
    fi
}


mapfile -d '' wallpapers < <(
    find "$WALLPAPER_DIR" \
        -type f \
        \( \
            -iname "*.jpg" \
            -o -iname "*.jpeg" \
            -o -iname "*.png" \
            -o -iname "*.bmp" \
            -o -iname "*.gif" \
            -o -iname "*.webp" \
        \) \
        -print0 |
    sort -z
)


[[ ${#wallpapers[@]} -eq 0 ]] && exit 1



selection=$(
    for img in "${wallpapers[@]}"; do

        thumb=$(gen_thumb "$img")

        printf "%s\x00icon\x1f%s\x1finfo\x1f%s\n" \
            "$(basename "$img")" \
            "$thumb" \
            "$img"

    done |
    rofi \
        -dmenu \
        -p "Wallpaper" \
        -show-icons \
        -theme "$ROFI_THEME"
)


[[ -z "$selection" ]] && exit 1



selected=""

for img in "${wallpapers[@]}"; do
    if [[ "$(basename "$img")" == "$selection" ]]; then
        selected="$img"
        break
    fi
done



if [[ -z "$selected" ]]; then
    notify-send "Wallpaper" "Failed to find: $selection" -u critical
    exit 1
fi



mode=$(detect_mode "$selected")
index=$(detect_index "$selected")



awww img "$selected" \
    --transition-type wave \
    --transition-angle 90 \
    --transition-duration 3 \
    --transition-fps 60 \
    --transition-wave 40,40



matugen image "$selected" \
    --mode "$mode" \
    --source-color-index "$index"



sudo /usr/local/bin/sddm-generate-theme "$selected"



notify-send \
    "Wallpaper" \
    "Set to: $selection ($mode, s$index)"

exit 0
