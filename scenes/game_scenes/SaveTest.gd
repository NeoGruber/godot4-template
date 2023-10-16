extends Node2D

func save():
	return {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"foo": "bar"
	};

func load_data(data):
	print(data);
