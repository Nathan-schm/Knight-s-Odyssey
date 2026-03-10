extends Node2D

@export_file("*.tscn") var next_scene

var level: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		print(level)
	

func _setup_level() -> void:
	
	var exit = $LevelRoot.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
		

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		print(level)
