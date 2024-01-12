extends Area2D


@export var speed = 1000.0
@export var max_range = 1200.0
@export var damage = 1
@export var distance_traversed = 0
@export var hp = 3

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	distance_traversed += speed * delta
	if distance_traversed > max_range:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)


func enemy_hit():
	print("enemy hit")
	hp -= 1
	if hp <= 0:
		queue_free()

"""
func _on_hurt_box_hurt(damage):
	hp -= 1
	if hp <= 0:
		queue_free()
"""
