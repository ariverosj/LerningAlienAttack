extends Control

@onready var score_label= $Panel/Score_Label
var main 

func set_score(score):
	var text="Score: "+str(score)
	score_label.text=text
	
	
func _on_button_pressed():
	get_tree().reload_current_scene()
