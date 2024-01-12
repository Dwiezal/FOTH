extends Node2D

var maxMobs = 64
@export var mobCount = 0
@export_enum("res://weak_slime.tscn", "something", "something_else") var mobVars = 0

"""
func _on_mob_timer_timeout():
	# spawn_mob()
	pass
"""

func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true

func _on_restart_pressed():
	get_tree().paused = false	
	get_tree().reload_current_scene()
	# print("button pressed")
	# %GameOver.visible = false

"""
func _on_mob_mo_died():
	mobCount -= 1
	# print(mob_count)
"""

func _on_player_level_up():
	%LevelUp.visible = true
	get_tree().paused = true

func _on_return_pressed():
	%LevelUp.visible = false
	get_tree().paused = false
