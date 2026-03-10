extends Node

@onready var label: Label = %Label

func add_point():
	Calcul.add_score(10)
	label.text = str(Calcul.total_score)

func _ready() -> void:
	Calcul.save_checkpoint()
	label.text = str(Calcul.total_score)
