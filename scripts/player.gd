extends CharacterBody2D

#variabeles
@export var speed = 300.0
@export var hp = 100.0

signal health_depleted

func _physics_process(delta):
	
	var direction = Input.get_vector("move_left", "move_right", 
										"move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
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
