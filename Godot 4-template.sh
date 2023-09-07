#!/bin/sh
echo -ne '\033c\033]0;Godot 4-template\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Godot 4-template.x86_64" "$@"
