extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D
@onready var pause = $Camera2D/Pause
@onready var resumeButtons = $Camera2D/Pause/MarginContainer/VBoxContainer/Resume
@onready var dialogue = $Camera2D/Dialogue	
@onready var text = $Camera2D/Dialogue/Dialoguebubble/Text
@onready var death = $Camera2D/Death
@onready var speedrun = $Camera2D/Speedrun
@onready var restartButton = $Camera2D/Death/MarginContainer/VBoxContainer/Restart
@onready var dialogueDection : Area2D = $DialogueDetector
@onready var heyBubble = $Camera2D/Heybubble

@onready var list_dialogues = {
	"test": DialogueTest.new(),
	"DialogueRobotCasse": RobotCasseDialogue.new(),
	"DialoguePanneau1": Panneau1Dialogue.new(),
}


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var paused = false
var inDialogue = false
var dead = false

var wasOffFloor = false
var maxHeight

var currentDialogue
var actualText = ""
var textIndex = 0
var deltaEveryLetter = 0.05
var timeSinceLastLetter = 0

var deathAnimation = 0

func _ready() -> void:
	maxHeight = position.y
	currentDialogue = list_dialogues["test"]
	Globals.speedrun_time = 0
	inDialogue = true
	if(Globals.have_finish_game == "false"):
		speedrun.hide()
	if(Globals.have_finish_game == "true"):
		sprite.play("default_golden")

func _physics_process(delta: float) -> void:
	if inDialogue:
		return
	if dead:
		return
	# Add the gravity.
	if is_on_floor():
		if wasOffFloor:
			if position.y > maxHeight + 128:
				dead = true
				speedrun.shouldcontinue = false
				if(Globals.have_finish_game == "true"):
					sprite.play("death_golden")
				else:
					sprite.play("death")
				Globals.save()
				restartButton.grab_focus()
			wasOffFloor = false
		maxHeight = get_position().y
	else:
		wasOffFloor = true
		if position.y < maxHeight:
			maxHeight = position.y
	

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
	var isOverlapping = false
	if(dialogueDection.has_overlapping_areas):
		for area in dialogueDection.get_overlapping_areas():
			if area.name.contains("Dialogue"):
				isOverlapping = true
	if(isOverlapping):
		heyBubble.show()
	else:
		heyBubble.hide()


	if(position.y > -150 and not dead):
		dead = true
		speedrun.shouldcontinue = false
		if(Globals.have_finish_game == "true"):
			sprite.play("death_golden")
		else:
			sprite.play("death")
		restartButton.grab_focus()
	if(dead):
		death.show()
		deathAnimation += _delta
		if(deathAnimation >= 3):
			deathAnimation = 3
		death.modulate.a = deathAnimation / 3


	if Input.is_action_just_pressed("pause"):
		paused = !paused
		resumeButtons.grab_focus()
	if paused:
		pause.show()
		Engine.time_scale = 0
	else:
		pause.hide()
		Engine.time_scale = 1
	
	if inDialogue:
		text.text = actualText
		dialogue.show()
		Engine.time_scale = 1
		if(currentDialogue.getDialogue()[textIndex]["type"] == "message"):
			if(timeSinceLastLetter >= deltaEveryLetter):
				text.text = actualText
				if(len(actualText) < len(currentDialogue.getDialogue()[textIndex]["text"])):
					actualText += currentDialogue.getDialogue()[textIndex]["text"][len(actualText)]
				timeSinceLastLetter = 0
			else:
				timeSinceLastLetter += _delta
		if(currentDialogue.getDialogue()[textIndex]["type"] == "end"):
			inDialogue = false
			dialogue.hide()
			Engine.time_scale = 1
		if(currentDialogue.getDialogue()[textIndex]["type"] != "message" and currentDialogue.getDialogue()[textIndex]["type"] != "end"):
			if(currentDialogue.getDialogue().size() > textIndex):
				textIndex = 0
				actualText = ""
				dialogue.hide()
				inDialogue = false
			else:
				textIndex += 1
				actualText = ""
				timeSinceLastLetter = 0
	else:
		dialogue.hide()
		Engine.time_scale = 1
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if(inDialogue):
			if(textIndex >= currentDialogue.getDialogue().size()-1):
				textIndex = 0
				actualText = ""
				dialogue.hide()
				inDialogue = false
			else:
				textIndex += 1
				actualText = ""
				timeSinceLastLetter = 0
	if(event.is_action_pressed("parler")):
		if(heyBubble.visible):
			var areaDialogueName = ""
			for areas in dialogueDection.get_overlapping_areas():
				if(areas.name.contains("Dialogue")):
					areaDialogueName = areas.name
			currentDialogue = list_dialogues[areaDialogueName]
			inDialogue = true



func _on_resume_pressed() -> void:
	paused = false

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainTitle.tscn")


func _on_restart_pressed() -> void:
	Globals.speedrun_time = 0
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
