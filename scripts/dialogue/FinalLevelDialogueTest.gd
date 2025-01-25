extends Dialogue
class_name FinalLevelDialogueTest

static var liste_dialogues = [
	{
		"type": "message",
		"speaker": "Bard",
		"text": "launch_final_level"
	},
	{
		"type": "runGame",
		"level": 8
	}
]

var nameDiag = "finalLevelTest"

func getDialogue():
	return liste_dialogues

func getName():
	return nameDiag
