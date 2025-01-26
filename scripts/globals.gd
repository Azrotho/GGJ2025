extends Node

static var language: String = "fr"
static var actual_dialog: String = "test"

var speedrun_time : float = 0
var have_finish_game : String

func _ready() -> void:
	have_finish_game = SaveAndLoad.load_data(have_finish_game)

func save():
	SaveAndLoad.save(have_finish_game)


@warning_ignore("unused_signal")
signal enter_music_zone1()
@warning_ignore("unused_signal")
signal exit_music_zone1()
@warning_ignore("unused_signal")
signal enter_music_zone2()
@warning_ignore("unused_signal")
signal exit_music_zone2()
@warning_ignore("unused_signal")
signal enter_music_zone3()
@warning_ignore("unused_signal")
signal exit_music_zone3()
