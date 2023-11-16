extends CenterContainer

onready var bar = $VBoxContainer/HBoxContainer/Bars/Bar

var current_health = 0

func _ready():
	current_health = 3
	set_health()

func set_health():
	current_health = clamp(current_health, 0, 3)
	bar.update_health(current_health)

func _on_Add_pressed():
	current_health += 1
	set_health()
	

func _on_remove_pressed():
	current_health -= 1
	set_health()
