extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_1.tscn")


func _on_quitter_button_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	$Label.text = "Score total : " + str(Calcul.total_score)
