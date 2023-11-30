extends Node
export(PackedScene) var game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var new_game = game.instance()
	new_game.connect("end", self, "show_end")
	$New_game.add_child(new_game)
	$Menu.hide()

func show_end():
	$"Game Over".visible = true
	$New_game.get_child(0).queue_free()

func _on_Restart_pressed():
	var new_game = game.instance()
	new_game.connect("end", self, "show_end")
	$New_game.add_child(new_game)
	$"Game Over".hide()
