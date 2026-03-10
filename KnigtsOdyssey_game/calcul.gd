extends Node

var total_score = 0
var score_checkpoint = 0  # score au début du niveau

func add_score(points: int) -> void:
	total_score += points

func save_checkpoint() -> void:
	score_checkpoint = total_score  # sauvegarde le score en début de niveau

func reset_to_checkpoint() -> void:
	total_score = score_checkpoint  # revient au score du début du niveau
