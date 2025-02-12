extends StaticBody2D
@onready var finished = $FinishedTutorial
@onready var unfinished = $UnfinishedTutorial
var tutorialcompletion: bool = false

func _on_area_2d_area_entered(area):
	if tutorialcompletion == false:
		unfinished.visible = true
	elif tutorialcompletion == true:
		finished.visible = true

func _on_area_2d_area_exited(area):
	if tutorialcompletion == false:
		unfinished.visible = false
	elif tutorialcompletion == true:
		finished.visible = false
