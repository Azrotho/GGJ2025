extends Node2D

@onready var MusicOne = $MusicOne
@onready var MusicTwo = $MusicTwo
@onready var MusicThree = $MusicThree

func _ready() -> void:
	MusicTwo.volume_db = -96
	MusicThree.volume_db = -96
	MusicOne.volume_db = -9

	MusicOne.play()
	MusicTwo.play()
	MusicThree.play()
	
var target_volume_music_one = -9
var target_volume_music_two = -96
var target_volume_music_three = -96
var fade_speed = 8.0

func _process(delta: float) -> void:
	if MusicOne.volume_db < target_volume_music_one:
		MusicOne.volume_db = min(MusicOne.volume_db + fade_speed * delta, target_volume_music_one)
	elif MusicOne.volume_db > target_volume_music_one:
		MusicOne.volume_db = max(MusicOne.volume_db - fade_speed * delta, target_volume_music_one)

	if MusicTwo.volume_db < target_volume_music_two:
		MusicTwo.volume_db = min(MusicTwo.volume_db + fade_speed * delta, target_volume_music_two)
	elif MusicTwo.volume_db > target_volume_music_two:
		MusicTwo.volume_db = max(MusicTwo.volume_db - fade_speed * delta, target_volume_music_two)

	if MusicThree.volume_db < target_volume_music_three:
		MusicThree.volume_db = min(MusicThree.volume_db + fade_speed * delta, target_volume_music_three)
	elif MusicThree.volume_db > target_volume_music_three:
		MusicThree.volume_db = max(MusicThree.volume_db - fade_speed * delta, target_volume_music_three)

@warning_ignore("unused_signal")
func _on_music_zone_1_body_entered(_body: Node2D) -> void:
	# Set target volume to fade in music 1
	if(_body.name == "Player"):
		target_volume_music_one = -9

@warning_ignore("unused_signal")
func _on_music_zone_1_body_exited(_body: Node2D) -> void:
	# Set target volume to fade out music 1
	if(_body.name == "Player"):
		target_volume_music_one = -96

@warning_ignore("unused_signal")
func _on_music_zone_2_body_entered(_body: Node2D) -> void:
	# Set target volume to fade in music 2
	if(_body.name == "Player"):
		target_volume_music_two = -9

func _on_music_zone_2_body_exited(_body: Node2D) -> void:
	# Set target volume to fade out music 2
	if(_body.name == "Player"):
		target_volume_music_two = -96

func _on_music_zone_3_body_entered(_body: Node2D) -> void:
	# Set target volume to fade in music 3
	if(_body.name == "Player"):
		target_volume_music_three = -9

func _on_music_zone_3_body_exited(_body: Node2D) -> void:
	# Set target volume to fade out music 3
	if(_body.name == "Player"):
		target_volume_music_three = -96
