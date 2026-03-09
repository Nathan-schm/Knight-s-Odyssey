extends Area2D

# Type de l'effet : "speed_boost", "jump_boost", ou "speed_malus"
@export_enum("speed_boost", "jump_boost", "speed_malus") var effect_type: String = "speed_malus"

# Durée de l'effet en secondes
@export var duration: float = 5.0

func _on_body_entered(body: Node2D) -> void:
	print("quelque chose a touché le pickup : ", body.name)
	if body.is_in_group("Player"):
		print("c'est le joueur !")
		body.apply_effect(effect_type, duration)
		queue_free()
