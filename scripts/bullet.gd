extends Area2D


@export var speed = 1000.0
@export var range = 1200.0
@export var dmg = 1
@export var distance_traversed = 0
@export var hp = 10

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	distance_traversed += speed * delta
	if distance_traversed > range:
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(dmg)


func _on_hurt_box_hurt(damage):
	hp -= 1
	if hp <= 0:
		queue_free()
