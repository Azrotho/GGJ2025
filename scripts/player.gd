extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D
@onready var pause = $Camera2D/Pause
@onready var resumeButtons = $Camera2D/Pause/MarginContainer/VBoxContainer/Resume
@onready var dialogue = $Camera2D/Dialogue	
@onready var text = $Camera2D/Dialogue/Dialoguebubble/Text

@onready var list_dialogues = {
	"test": DialogueTest.new(),
	"test2": DialogueTest2.new(),
	"finalLevelTest": FinalLevelDialogueTest.new()
}


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var paused = false
var inDialogue = false

var currentDialogue
var actualText = ""
var textIndex = 0
var deltaEveryLetter = 0.1
var timeSinceLastLetter = 0

func _ready() -> void:
	currentDialogue = list_dialogues["test"]
	inDialogue = true


func _physics_process(delta: float) -> void:
	if inDialogue:
		return
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
		if(textIndex >= currentDialogue.getDialogue().size()-1):
			textIndex = 0
			actualText = ""
			dialogue.hide()
			inDialogue = false
		else:
			textIndex += 1
			actualText = ""
			timeSinceLastLetter = 0


func _on_resume_pressed() -> void:
	paused = false

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainTitle.tscn")
