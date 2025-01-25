extends Dialogue
class_name DialogueTest2

static var liste_dialogues = [
    {
        "type": "message",
        "speaker": "Bard",
        "text": "try_choice_double"
    },
    {
        "type": "choice",
        "numberOfChoices": 2,
        "choice1": "test_choix_2_1",
        "choice2": "test_choix_2_2",
        "runDialogueChoice1": "test",
        "runDialogueChoice2": "test"
    }
]

var nameDiag = "test2"

func getDialogue():
    return liste_dialogues

func getName():
    return nameDiag