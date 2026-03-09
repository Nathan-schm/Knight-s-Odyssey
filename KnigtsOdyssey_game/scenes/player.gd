extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var can_move = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func die():
	print("dead called")
	can_move = false
	velocity = Vector2.ZERO
	animated_sprite.play("dead")

func _physics_process(delta):
	# ajoute la gravité
	if not is_on_floor():
		velocity += get_gravity() * delta


	if can_move:

		# saut 
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("move_left", "move_right")
		
		# changement de direction du joueur graphiquement 
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true 
		
		
		#déplacement gauche droite avec animation
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else :
			animated_sprite.play("jump")
		
		# vitesse de déplacement 
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)



	move_and_slide()
