extends Control
export(PackedScene) var PauseDialog

var current_health = 3
var score = 0

func _ready():
	pass # Replace with function body.


func _on_Pause_pressed():
	var new_info = PauseDialog.instance()
	add_child(new_info)

func add_score():
	score += 1
	$Score.text = str(score)
	
func reinit_score():
	score = 0
	$Score.text = str(0)

func add_health():
	current_health = clamp(current_health + 1, 0, 3)
	$HeartContainer.update_health(current_health)
	
func decrease_health():
	current_health = clamp(current_health - 1, 0, 3)
	$HeartContainer.update_health(current_health)
	
func restart_power():
	$PowerCooldown.reinit()
	
func restart_hud():
	current_health = 3
	$HeartContainer.update_health(current_health)
	$PowerCooldown.value = 100
	reinit_score()
	
func _on_Add_Health_pressed():
	add_health()

func _on_Decrese_Health_pressed():
	decrease_health()
	
func _on_Reinit_Timer_pressed():
	restart_power()
