extends Area2D

# var enemies_in_range
@export var reload_time = 1.0

func _physics_process(delta):
	# enemies_in_range = get_overlapping_bodies()
	# if enemies_in_range.size() > 0:
		# var target_enemy = enemies_in_range.front()
		# look_at(target_enemy.global_position)
	look_at(get_global_mouse_position())


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
	# if enemies_in_range.size() > 0:
	shoot()
