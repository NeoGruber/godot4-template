extends CanvasLayer

@onready var save_system = get_node("/root/Main/SaveSystem")

func _ready():
	save_system.load_player_info()
