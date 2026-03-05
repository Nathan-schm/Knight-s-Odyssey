extends Node

var score = 0

@onready var label: Label = %Label



func add_point ():
	score += 10
	label.text = str(score) 
