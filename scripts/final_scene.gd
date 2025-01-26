extends Node2D

@onready var timeText = $Camera2D/Label3
@onready var button = $Camera2D/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.grab_focus()
	var time = Globals.speedrun_time
	var formatted_time = str(time)
	var decimal_index = formatted_time.find(".")
	
	if decimal_index > 0:
		formatted_time = formatted_time.left(decimal_index + 9)  # Take
	timeText.text = ("Time: " + formatted_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainTitle.tscn")
