extends CharacterBody2D

# general vars
@export var hp = 3
@export var size = 1.0
# @export var speed = 100.0

# flocking vars
@export var max_speed: = 200.0
@export var target_force: = 0.05
@export var cohesion_force: = 0.05
@export var align_force: = 0.05
@export var separation_force: = 0.05
@export var view_distance: = 200.0
@export var avoid_distance: = 20.0

# onreadys
@onready var player = get_node("/root/Game/Player")
@onready var listener = "res://survivors_game.tscn" #reference to your listener here 

# other other
var _width = ProjectSettings.get_setting("display/window/size/viewport_width")
var _height = ProjectSettings.get_setting("display/window/size/viewport_height")

var _flock: Array = []
var _target: Vector2
var _velocity: Vector2
var target_vector: Vector2

signal died

func _ready():
	# apply_scale(Vector2(size, size))
	%BloguAnimation.play_walk()
	_velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)
						).normalized() * max_speed
	_target = player.global_position


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

"""
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	"""
"""
func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		died.emit()
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
"""

func _on_hurt_box_hurt(damage):
	hp -= damage
	%BloguAnimation.play_hurt()
	print(hp)
	if hp <= 0:
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()

func get_random_target():
	randomize()
	return Vector2(randf_range(0, _width), randf_range(0, _height))
