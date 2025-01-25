extends Control

@onready var backButton = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backButton.grab_focus()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainTitle.tscn")
