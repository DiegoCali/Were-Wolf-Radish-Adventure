extends RigidBody2D
var time_alive = 0

func _ready():
	$Timer.start()
	$AnimatedSprite.playing = true
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Timer_timeout():
	time_alive += 1
	if time_alive > 5:
		queue_free()
