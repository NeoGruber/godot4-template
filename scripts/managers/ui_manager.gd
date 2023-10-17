extends Control

@export var default_name = "username"

@onready var save_system = get_node("/root/Main/SaveSystem")

@onready var player_name_line_edit = $MarginContainer/MenuVBox/MenuRowVBox/UsernameHBox/LineEdit

var player_name = default_name

func _ready():
	player_name_line_edit.text = player_name
	print("set line text")

func _on_button_button_down():
	player_name = player_name_line_edit.text
	save_system.save_player_info()

func save():
	return {
		"player_name": player_name
	};
	
func load_data(data):
	player_name = data["player_name"]
