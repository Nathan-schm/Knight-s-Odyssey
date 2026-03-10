extends CharacterBody2D


const BASE_SPEED = 130.0
const BASE_JUMP_VELOCITY = -300.0

var speed = BASE_SPEED
var jump_velocity = BASE_JUMP_VELOCITY
var can_move = true

# Timers des effets actifs
var active_timers = {}

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func die():
	print("dead called")
	can_move = false
	velocity = Vector2.ZERO
	animated_sprite.play("dead")
	Calcul.reset_to_checkpoint()

func _physics_process(delta):
	# ajoute la gravité
	if not is_on_floor():
		velocity += get_gravity() * delta


	if can_move:

		# saut 
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity

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
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)



	move_and_slide()


# === Système de boosts / malus ===

func apply_effect(type: String, duration: float) -> void:
	match type:
		"speed_boost":
			speed = BASE_SPEED * 1.6
			_start_effect_timer("speed_boost", duration, func(): speed = BASE_SPEED)

		"jump_boost":
			jump_velocity = BASE_JUMP_VELOCITY * 1.4
			_start_effect_timer("jump_boost", duration, func(): jump_velocity = BASE_JUMP_VELOCITY)

		"speed_malus":
			speed = BASE_SPEED * 0.5
			jump_velocity = BASE_JUMP_VELOCITY * 0.5
			_start_effect_timer("speed_malus", duration, func(): speed = BASE_SPEED,)
			_start_effect_timer("jump_boost", duration, func(): jump_velocity = BASE_JUMP_VELOCITY)

func _start_effect_timer(id: String, duration: float, callback: Callable) -> void:
	# Si l'effet est déjà actif, on repart de zéro
	if active_timers.has(id) and is_instance_valid(active_timers[id]):
		active_timers[id].queue_free()

	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = duration
	timer.one_shot = true
	timer.timeout.connect(callback)
	timer.timeout.connect(timer.queue_free)
	timer.start()
	active_timers[id] = timer
