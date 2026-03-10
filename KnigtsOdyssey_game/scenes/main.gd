extends Node2D

var level: int = 1

func _setup_level() -> void:
	
	var exit = $LevelRoot.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_body_entered)
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		print(body)
