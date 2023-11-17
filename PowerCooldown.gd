extends ProgressBar

func _ready():
	$Timer.start()
	$AudioStreamPlayer.autoplay = false

func _on_Timer_timeout():
	if value < 100:
		value += 1
	else:
		$AudioStreamPlayer.play()
		$Timer.stop()

func reinit():
	value = 0
	$Timer.start()


