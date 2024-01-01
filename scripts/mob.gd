extends CharacterBody2D

@export var hp = 3
@export var speed = 100.0
@export var size = 1.0

@onready var player = get_node("/root/Game/Player")
@onready var listener = "res://survivors_game.tscn"#reference to your listener here 

signal died

func _ready():
	# apply_scale(Vector2(size, size))
	%Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

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
	%Slime.play_hurt()
	print(hp)
	if hp <= 0:
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
