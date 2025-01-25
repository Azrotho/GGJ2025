extends Control

@onready var credits = preload("res://scenes/Credits.tscn")
@onready var game = preload("res://scenes/Game.tscn")
@onready var playButtons = $MarginContainer/VBoxContainer/Play

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.speedrun_time = 0
	playButtons.grab_focus()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(game)


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credits)


func _on_quit_pressed() -> void:
	get_tree().quit()
