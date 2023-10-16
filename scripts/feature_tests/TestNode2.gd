extends Node2D

signal test(foo)

func _input(event):
	if event.is_action_pressed("debug_button_9"):
		test.emit("hello")
