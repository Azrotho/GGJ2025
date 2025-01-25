extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D
@onready var pause = $Camera2D/Pause
@onready var resumeButtons = $Camera2D/Pause/MarginContainer/VBoxContainer/Resume

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var paused = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not paused:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if(velocity.x > 0):
		sprite.scale.x = 1
	if(velocity.x < 0):
		sprite.scale.x = -1
	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		resumeButtons.grab_focus()
	if paused:
		pause.show()
		Engine.time_scale = 0
	else:
		pause.hide()
		Engine.time_scale = 1
		


func _on_resume_pressed() -> void:
	paused = false

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainTitle.tscn")
