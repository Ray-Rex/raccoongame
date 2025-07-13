extends Node

var score = 0
#@onready var score_label: Label = $"../Texts/ScoreLabel"

func add_point():
	score += 1
	#score_label.text = "skor lu: " + str(score) + " koin"
	print(score)
