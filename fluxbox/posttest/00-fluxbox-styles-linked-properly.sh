#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

fluxbox_styles_dir=~/.fluxbox/styles
styles_path=$CONFIGITOR_BASE_DIR/fluxbox/styles

cd  $styles_path

for style in *; do
    original_style=$fluxbox_styles_dir/$style
    current_style_path=$styles_path/$style
    link_file=`readlink "$original_style"`
    if [ "$link_file" != "$current_style_path" ]; then
        c_error "Fluxbox style has invalid link: $original_style" 
    fi
done

cd - 1>/dev/null

c_success 'All fluxbox style links are valid' 
 
