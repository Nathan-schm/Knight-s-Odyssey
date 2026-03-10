extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://scenes/screen_fin.tscn")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_1.tscn")
	pass # Replace with function body.



func _on_quitter_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
