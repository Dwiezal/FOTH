extends AnimatedSprite2D


func play_idle():
	play("idle")
	# %SloshySloshing.flip_h = false
	%SloshySloshing.play("idle")
func play_idle_L():
	play("idle_L")
	# %SloshySloshing.flip_h = true
	%SloshySloshing.play("idle_L")


func play_walk():
	play("walk")
	# %SloshySloshing.flip_h = false
	%SloshySloshing.play("walk")
func play_walk_L():
	play("walk_L")
	# %SloshySloshing.flip_h = true
	%SloshySloshing.play("walk_L")


func play_float_attack():
	play("float_attack")
	%SloshySloshing.play("float_attack")


func play_spawning():
	play("spawning")
	%SloshySloshing.play("spawning")
