#!/usr/bin/env bash


sketchybar --add event aerospace_workspace_change

for m in $(aerospace list-monitors | awk '{print $1}')
do
    for i in $(aerospace list-workspaces --monitor $m)
    do
        sid=$i
        sketchybar --add space space.$sid left \
            --set space.$sid \
            icon=$sid \
            icon.padding_left=8 \
            label.drawing=on \
            label.font="sketchybar-app-font:Regular:12.0" \
            label.padding_right=8 \
            label.y_offset=-1\
            display=$m \
            background.height=20 \
            background.border_color=0x70ff4f00 \
            background.drawing=on \
            background.corner_radius=20 \
            background.border_width=1 \
            click_script="aerospace workspace $sid" \
            script="$CONFIG_DIR/plugins/aerospace.sh $sid" \
            --subscribe space.$sid aerospace_workspace_change 

        apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

        icon_strip=""
        if [ "${apps}" != "" ]; then
          while read -r app
          do
            icon_strip+="$($CONFIG_DIR/plugins/icon_map.sh "$app") "
          done <<< "${apps}"
        else
          icon_strip="-"
        fi

        sketchybar --set space.$sid label="$icon_strip"
    done
done


