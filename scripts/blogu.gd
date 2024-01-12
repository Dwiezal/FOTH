extends CharacterBody2D

# general vars
@export var hp = 3
@export var size = 1.0
@export var xp = 1
# @export var speed = 100.0

# flocking vars
@export var max_speed: = 200.0
@export var target_force: = 0.05
@export var cohesion_force: = 0.05
@export var align_force: = 0.05
@export var separation_force: = 0.05
@export var view_distance: = 200.0
@export var avoid_distance: = 20.0
@export var attack_range: = 200.0

# onreadys
@onready var player = get_node("/root/Game/Player")
@onready var listener = "res://survivors_game.tscn" #reference to your listener here 
@onready var animp = %BloguAnimation

# other other
var _width = ProjectSettings.get_setting("display/window/size/viewport_width")
var _height = ProjectSettings.get_setting("display/window/size/viewport_height")

var _flock: Array = []
var _target: Vector2
var _velocity: Vector2
var target_vector: Vector2

var done_hurting = false
var is_attacking = false

const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
const DMGNUM_SCENE = preload("res://damage_indicator.tscn")
const SPLAT_SCENE = preload("res://xp.tscn")

signal died

func _ready():
	# apply_scale(Vector2(size, size))
	animp.play_walk()
	_velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)
						).normalized() * max_speed
	_target = player.global_position

func update_animations(velocity):
	var anim = animp.get_animation()
	match anim:
		"hurt": return
		"hurt_L": return
		"attack": return
		"attack_L": return
		# "attacking": return
		# "attacking_L": return
	if velocity.x > 0:
		if is_attacking:
			animp.play_attacking()
		else:
			animp.play_walk()
	elif velocity.x < 0:
		if is_attacking:
			animp.play_attacking_L()
		else:
			animp.play_walk_L()
	else:
		if is_attacking:
			match anim:
				"attacking": animp.play_attacking()
				"attacking_L": animp.play_attacking_L()
		else:
			match anim:
				"walk": animp.play_walk()
				"walk_L": animp.play_walk_L()

func _on_flock_view_body_entered(body: PhysicsBody2D):
	if self != body:
		if body.is_in_group("enemy"):
			_flock.append(body) #adds bodies to flock when in range


func _on_flock_view_body_exited(body):
	if body.is_in_group("enemy"):
		_flock.remove_at(_flock.find(body)) #removed bodies from flock when far

func _physics_process(delta):
	if Engine.get_physics_frames() % 4 == 0:
		var target_vector = Vector2.ZERO
		_target = player.global_position
		if _target != Vector2.INF:
			target_vector = global_position.direction_to(
								_target) * max_speed * target_force

		# get cohesion, alignment, and separation vectors
		var vectors = get_flock_status(_flock)

		# steer towards vectors
		var cohesion_vector = vectors[0] * cohesion_force
		var align_vector = vectors[1] * align_force
		var separation_vector = vectors[2] * separation_force

		var acceleration = (cohesion_vector + align_vector + 
							separation_vector + target_vector)

		_velocity = (_velocity + acceleration).limit_length(max_speed)

		set_velocity(_velocity)
		update_animations(velocity)
	move_and_slide()
	_velocity = velocity


func get_flock_status(flock: Array):
	var center_vector: = Vector2()
	var flock_center: = Vector2()
	var align_vector: = Vector2()
	var avoid_vector: = Vector2()

	for f in flock:
		var neighbor_pos: Vector2 = f.global_position

		align_vector += f._velocity
		flock_center += neighbor_pos

		var d = global_position.distance_to(neighbor_pos)
		if d > 0 and d < avoid_distance:
			avoid_vector -= (neighbor_pos - global_position).normalized() * (
							avoid_distance / d * max_speed)

	var flock_size = flock.size()
	if flock_size:
		align_vector /= flock_size
		flock_center /= flock_size

		var center_dir = global_position.direction_to(flock_center)
		var center_speed = max_speed * (global_position.distance_to(
							flock_center) / $FlockView/ViewRadius.shape.radius)
		center_vector = center_dir * center_speed

	return [center_vector, align_vector, avoid_vector]

func _on_hurt_box_hurt(damage):
	hp -= damage
	spawn_dmg_indicator(damage)
	if velocity.x >= 0:
		animp.play_hurt()
	else:
		animp.play_hurt_L()
	print(hp)
	if hp <= 0:
		# var smoke = SMOKE_SCENE.instantiate()
		# get_parent().add_child(smoke)
		# smoke.global_position = global_position
		spawn_effect(SMOKE_SCENE)
		spawn_effect(SPLAT_SCENE)
		queue_free()

func spawn_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position):
	var effect = EFFECT.instantiate()
	get_parent().add_child(effect)
	effect.global_position = global_position
	if effect.has_node("XPSplat"):
		effect.mobulate(xp)
	return effect

func spawn_dmg_indicator(damage):
	var dnum = spawn_effect(DMGNUM_SCENE)
	if dnum:
		dnum.label.text = str(damage)
	

func get_random_target():
	randomize()
	return Vector2(randf_range(0, _width), randf_range(0, _height))

func _on_blogu_animation_animation_finished():
	var anim = animp.get_animation()
	match anim:
		"hurt": animp.play_walk()
		"hurt_L": animp.play_walk_L()
		"attack": animp.play_attacking()
		"attack_L": animp.play_attacking_L()


func _on_atk_range_body_entered(body):
	if body.is_in_group("player"):
		is_attacking = true
		"""
		if velocity.x > 0:
			animp.play_attack()
		elif velocity.x < 0:
			animp.play_attack_L()
		else:
			match animp.get_animation:
				"walk": animp.attack()
				"walk_L": animp.attack_L()
		"""

func _on_atk_range_body_exited(body):
	if body.is_in_group("player"):
		is_attacking = false
		"""
		match animp.get_animation:
			"hurt": return
			"hurt_L": return
		if velocity.x > 0:
			animp.play_walk
		elif velocity.x <0:
			animp.play_walk_L
		"""
