extends AnimatedSprite2D


func play_idle_animation():
	play("idle")
	# %SloshySloshing.flip_h = false
	%SloshySloshing.play("idle")

func play_idle_animation_left():
	play("idle_L")
	# %SloshySloshing.flip_h = true
	%SloshySloshing.play("idle_L")


func play_walk_animation():
	play("walk")
	# %SloshySloshing.flip_h = false
	%SloshySloshing.play("walk")

func play_walk_animation_left():
	play("walk_L")
	# %SloshySloshing.flip_h = true
	%SloshySloshing.play("walk_L")

