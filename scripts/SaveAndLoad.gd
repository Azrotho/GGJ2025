class_name SaveAndLoad
extends Resource

static var save_path = "user://fishyfish.save"

static func save(have_finish_game):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(have_finish_game)
	
static func load_data(have_finish_game):
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		have_finish_game = file.get_as_text()
		return have_finish_game
	else:
		return "false"
