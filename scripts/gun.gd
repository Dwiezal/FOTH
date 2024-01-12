extends Area2D

var enemies_in_range

@export var turn_speed = 10000.0
@export var view_distance = 512.0

var pointing_at := Vector2.ZERO

func _physics_process(delta):
	pointing_at = pointing_at.move_toward(get_global_mouse_position(), delta * turn_speed)
	look_at(pointing_at)

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation + randf_range(-.05, .05)
	%ShootingPoint.add_child(new_bullet)
	# """
	const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke_scale = Vector2(0.25, 0.25)
	var smoke = SMOKE_SCENE.instantiate()
	smoke.apply_scale(smoke_scale)	
	get_parent().add_child(smoke)
	smoke.global_position = %ShootingPoint.global_position
	# """
	
func _on_timer_timeout():
	shoot()
