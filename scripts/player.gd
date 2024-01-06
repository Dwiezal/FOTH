extends CharacterBody2D

#variabeles
@export var hp = 100.0
@export var FRICTION = 100.0
@export var ACCELERATION = 1000.0
@export var SPEED = 300.0

signal health_depleted

func _ready():
	%PotionBattler.play_idle_animation()

func _player_movement(direction, delta):
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * SPEED , delta * ACCELERATION)

	else: 
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)

func update_animations(direction, velocity):
	# %PotionBattler/SloshySloshing.flip_h = (direction.x < 0)
	if direction == Vector2.ZERO:
		if velocity.x > 0:
			%PotionBattler.play_idle_animation()
		elif velocity.x < 0:
			%PotionBattler.play_idle_animation_left()
		else:
			match %PotionBattler.get_animation():
				"walk": %PotionBattler.play_idle_animation()
				"walk_L": %PotionBattler.play_idle_animation_left()
	elif velocity.x > 0:
		%PotionBattler.play_walk_animation()
	elif velocity.x < 0:
		%PotionBattler.play_walk_animation_left()
	else:
		match %PotionBattler.get_animation():
			"walk": %PotionBattler.play_walk_animation()
			"walk_L": %PotionBattler.play_walk_animation_left()
			"idle": %PotionBattler.play_walk_animation()
			"idle_L": %PotionBattler.play_walk_animation_left()

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", 
										"move_up", "move_down")
	_player_movement(direction, delta)
	update_animations(direction, velocity)
	# velocity = direction * SPEED
	move_and_slide()
	"""
	if velocity.length() > 0.0:
		
		# %HappyBoo.play_walk_animation()
	"""
	"""
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
				health_depleted.emit()
	"""


func _on_hurt_box_hurt(damage):
	hp -= damage
	%ProgressBar.value = hp
	print(hp)
	if hp <= 0.0:
		health_depleted.emit()
