extends ProgressBar

func _ready():
	value = 100

func _on_Timer_timeout():
	if value < 100:
		value += 1
	else:
		$AudioStreamPlayer.play()
		$Timer.stop()

func start_Timer():
	$Timer.start()

func reinit():
	value = 0
	$Timer.start()


