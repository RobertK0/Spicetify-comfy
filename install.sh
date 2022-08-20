#!/bin/sh

set -e

echo "Downloading"
# Setup directories to download to
theme_dir="$(dirname "$(spicetify -c)")/Themes"
ext_dir="$(dirname "$(spicetify -c)")/Extensions"

# Make directories if needed
mkdir -p "${theme_dir}/Comfy"
mkdir -p "${theme_dir}/Comfy-Mono"
mkdir -p "${theme_dir}/Comfy-Chromatic"
mkdir -p "${ext_dir}"

# Download latest tagged files into correct directories

curl --progress-bar --output "${theme_dir}/Comfy/color.ini" "https://robertk0.github.io/Spicetify-comfy/Comfy/color.ini"
curl --progress-bar --output "${theme_dir}/Comfy/user.css" "https://robertk0.github.io/Spicetify-comfy/Comfy/user.css"
curl --progress-bar --output "${ext_dir}/comfy.js" "https://robertk0.github.io/Spicetify-comfy/Comfy/comfy.js"

curl --progress-bar --output "${theme_dir}/Comfy-Mono/color.ini" "https://robertk0.github.io/Spicetify-comfy/Comfy-Mono/color.ini"
curl --progress-bar --output "${theme_dir}/Comfy-Mono/user.css" "https://robertk0.github.io/Spicetify-comfy/Comfy-Mono/user.css"
curl --progress-bar --output "${ext_dir}/comfy-mono.js" "https://robertk0.github.io/Spicetify-comfy/Comfy-Mono/comfy-mono.js"

curl --progress-bar --output "${theme_dir}/Comfy-Chromatic/color.ini" "https://robertk0.github.io/Spicetify-comfy/Comfy-Chromatic/color.ini"
curl --progress-bar --output "${theme_dir}/Comfy-Chromatic/user.css" "https://robertk0.github.io/Spicetify-comfy/Comfy-Chromatic/user.css"
curl --progress-bar --output "${ext_dir}/comfy-chromatic.js" "https://robertk0.github.io/Spicetify-comfy/Comfy-Chromatic/comfy-chromatic.js"

echo "Applying theme"
spicetify config extensions comfy.js
# Let users choose which theme they want to apply
echo "Please select a theme to apply:"
echo "1. Comfy [default]"
echo "2. Comfy-Mono"
echo "3. Comfy-Chromatic"
read -p "Choice: " choice
# Choose 1 if no input is given
if [ -z "${choice}" ]; then
    choice=1
fi
while true; do
    case $choice in
        1) spicetify config current_theme Comfy color_scheme Comfy
        break
        ;;
        2) spicetify config current_theme Comfy-Mono color_scheme Mono
        break
        ;;
        3) spicetify config current_theme Comfy-Chromatic color_scheme Sunset
        break
        ;;
        *) echo "Invalid choice, please try again"; read -p "Choice: " choice;;
    esac
done
# Apply theme
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify apply

echo "All done!"
