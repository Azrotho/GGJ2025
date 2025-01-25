extends Dialogue
class_name DialogueTest

static var liste_dialogues = [
	{
		"type": "message",
		"speaker": "Bard",
		"text": "Salut je suis Azrotho!"
	},
	{
		"type": "message",
		"speaker": "Bard",
		"text": "Je suis gentil"
	},
	{
		"type": "message",
		"speaker": "Bard",
		"text": "et je sens bon!"
	}
]

var nameDiag = "test"

func getDialogue():
	return liste_dialogues

func getName():
	return nameDiag
