extends CharacterBody2D

#variabeles
@export var hp = 100.0
@export var FRICTION = 100.0
@export var ACCELERATION = 1000.0
@export var SPEED = 300.0

@onready var animp = %PotionBattler

signal health_depleted

func _ready():
	animp.play_spawning()

func _player_movement(direction, delta):
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * SPEED , delta * ACCELERATION)

	else: 
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)

func update_animations(direction, vel):
	# animp/SloshySloshing.flip_h = (direction.x < 0)
	if animp.get_animation() == "spawning":
		return
	if direction == Vector2.ZERO:
		if velocity.x > 0:
			animp.play_idle()
		elif velocity.x < 0:
			animp.play_idle_L()
		else:
			match animp.get_animation():
				"walk": animp.play_idle()
				"walk_L": animp.play_idle_L()
	elif velocity.x > 0:
		animp.play_walk()
	elif velocity.x < 0:
		animp.play_walk_L()
	else:
		match animp.get_animation():
			"walk": animp.play_walk()
			"walk_L": animp.play_walk_L()
			"idle": animp.play_walk()
			"idle_L": animp.play_walk_L()

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", 
										"move_up", "move_down")
	_player_movement(direction, delta)
	update_animations(direction, velocity)
	# velocity = direction * SPEED
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	%ProgressBar.value = hp
	print(hp)
	if hp <= 0.0:
		health_depleted.emit()


func _on_potion_battler_animation_finished():
	match animp.get_animation():
		"spawning": animp.play_idle()
