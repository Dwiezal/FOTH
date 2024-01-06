extends Timer

signal delay_set

# Called when the node enters the scene tree for the first time.
func slosh_timer():
	wait_time = randf_range(0,0.3)
	delay_set.emit()
