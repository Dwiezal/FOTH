extends CharacterBody2D

#variabeles
@export var hp = 100.0
@export var FRICTION = 100.0
@export var ACCELERATION = 1000.0
@export var SPEED = 300.0

@onready var animp = %PotionBattler
@onready var player_experience := 0
@onready var level_point := 7

#GUN
var gun_reload_time = 1.0



signal health_depleted
signal level_up

func _ready():
	#GUN
	$Gun/Timer.wait_time = gun_reload_time
	
	animp.play_spawning()
	%ExperienceBar.value = 0.0
	%ExperienceBar.max_value = level_point

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
	%HealthBar.value = hp
	print(hp)
	if hp <= 0.0:
		health_depleted.emit()


func _on_potion_battler_animation_finished():
	match animp.get_animation():
		"spawning": animp.play_idle()

func add_xp(xp):
	player_experience += xp
	%ExperienceBar.value = player_experience
	if player_experience >= level_point:
		level_up.emit()
		player_experience -= level_point
		level_point *= 2
		%ExperienceBar.max_value = level_point
		%ExperienceBar.value = player_experience
	print("XP: ",player_experience)
