extends Area2D

@onready var compteur: Node = %compteur

func _on_body_entered(body):
	compteur.add_point()
	queue_free()
