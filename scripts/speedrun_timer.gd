extends Node2D
 
var time = Globals.speedrun_time
var shouldcontinue = true;

func _physics_process(delta):
	if(shouldcontinue):
		time = float(time) + delta
		update_ui()
	
func update_ui():
	# Format time with two decimal places
	var formatted_time = str(time)
	var decimal_index = formatted_time.find(".")
	
	if decimal_index > 0:
		formatted_time = formatted_time.left(decimal_index + 2)  # Take only two decimal places
	
	Globals.speedrun_time = formatted_time
		
	$Label.text = formatted_time
