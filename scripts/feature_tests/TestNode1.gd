extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$TestNode2.test.connect(print_debug)

func print_debug(foo):
	print(foo)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
