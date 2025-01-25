extends Dialogue
class_name RobotCasseDialogue

static var liste_dialogues = [
	{
		"type": "message",
		"text": "Hey kiddo! \n It's dangerous to go alone!"
	},
	{
		"type": "message",
		"text": "This tower is very high, \n be careful!"
	},
	{
		"type": "message",
		"text": "If you fall like me, \n you'll be in trouble!"
	},
	{
		"type": "message",
		"text": "Your bubble can pop if you fall \n from too high!"
	}
]

var nameDiag = "robotCasse"

func getDialogue():
	return liste_dialogues

func getName():
	return nameDiag
