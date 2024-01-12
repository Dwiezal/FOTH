extends Area2D

@export var pickup_radius := 50

# Called when the node enters the scene tree for the first time.
func _ready():
	%item_radius.shape.radius = pickup_radius

func _on_area_entered(area):
	var area_groups = area.get_groups()
	for i in range(area_groups.size()):
		var current_group = area_groups[i]
		match current_group:
			"XP": # splats and splooshes to level up your character mid run
				get_parent().add_xp(area.exp_stored) 
				area.queue_free()
			"Pickup": pass # things such as healing items and temporary boosters
			"Item": pass # things like weapons, accessories, and unlocks
			_: pass
