extends Node

static var language: String = "fr"
static var actual_dialog: String = "test"

var have_finish_game : String

func _ready() -> void:
	have_finish_game = SaveAndLoad.load_data(have_finish_game)

func save():
	SaveAndLoad.save(have_finish_game)
