extends Control

@onready var score_label= $Score
@onready var life_label= $Life_Text

func set_new_score(new_score):
	print("En Uso")
	var text = "SCORE. " + str(new_score)
	score_label.text=text

func set_life(new_life):
	life_label.text= str(new_life)

