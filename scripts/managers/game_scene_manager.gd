extends Node2D

func _input(event):
	if event.is_action_pressed("debug_button_0"):
		get_tree().root.get_node("Main/SceneManager").switch_scene("game_scene2")
