#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

fluxbox_styles_dir=~/.fluxbox/styles

for check_style in $fluxbox_styles_dir/*; do
    file=`readlink "$check_style"`
    if [ -h "$check_style" ] && [ ! -e "$file" ]; then
        unlink "$check_style"
    fi
done

styles_path=$CONFIGITOR_BASE_DIR/fluxbox/styles

cd  $styles_path
for style in *; do
    original_style=$fluxbox_styles_dir/$style
    create_backup "fluxbox" "$original_style"

    current_style_path=$styles_path/$style
    make_symbolic_link "$fluxbox_styles_dir" "$style" "$current_style_path" 
done
cd - 1>/dev/null
