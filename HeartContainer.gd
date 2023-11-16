extends HBoxContainer

var health = preload("res://Assets/Other/heart_container.png")

func update_health(value):
	for i in get_child_count():
		get_child(i).visible = value > i
	


