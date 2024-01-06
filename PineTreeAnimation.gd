extends AnimatedSprite2D


func _on_sway_timer_timeout():
	play("default")

func _on_sway_timer_delay_set():
	%SwayTimer.start()
