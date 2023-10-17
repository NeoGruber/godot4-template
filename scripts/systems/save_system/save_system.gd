extends Node

@export var player_info_file_name = "player"

@export var player_info_nodes_group_name = "player"

@export var settings_file_name = "settings"

@export var settings_nodes_group_name = "settings"

@export var save_game_nodes_group_name = "saveable";

func save_player_info():
	save_file("user://" + player_info_file_name + ".save", player_info_nodes_group_name)
	
func load_player_info():
	load_file("user://" + player_info_file_name + ".save", player_info_nodes_group_name)

func save_options():
	save_file("user://" + settings_file_name + ".save", settings_nodes_group_name)

func load_options():
	load_file("user://" + settings_file_name + ".save", settings_nodes_group_name)

func save_game(game_name):
	save_file("user://" + game_name + ".save", save_game_nodes_group_name)

func load_game(game_name):
	load_file("user://" + game_name + ".save", save_game_nodes_group_name)


func save_file(file_name, save_group_name):
	print("save file: " + file_name)
	
	var file_to_save = FileAccess.open(file_name, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group(save_group_name)
	for node in save_nodes:
		
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		var node_data = node.call("save")
		
		node_data["filename"] = node.get_scene_file_path()
		node_data["parent"] = get_parent().get_path()
		
		var json_string = JSON.stringify(node_data)
		
		file_to_save.store_line(json_string)

func load_file(file_name, save_group_name):
	print("load file: " + file_name)
	
	if not FileAccess.file_exists(file_name):
		return

	var file_to_load = FileAccess.open(file_name, FileAccess.READ)
	
	if file_to_load.get_length() == 0:
		print("file was empty")
		return
	
	var save_nodes = get_tree().get_nodes_in_group(save_group_name)
	for i in save_nodes:
		i.queue_free()
	
	while file_to_load.get_position() < file_to_load.get_length():
		var json_string = file_to_load.get_line()

		var json = JSON.new()

		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		var node_data = json.get_data()

		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).call_deferred("add_child", new_object)
		print("add child")
		print(new_object.name)
		new_object.call("load_data", node_data)

		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
