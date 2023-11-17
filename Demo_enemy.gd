extends Node 
export(PackedScene) var Enemy

var actual_mobs = get_child_count()
var collided = 0

func _ready():
	randomize()
	$Timer.start()

func _on_Timer_timeout():
	$Label.text = str(collided)
	$Position2D.position.x = rand_range(100.0, 500.0)
	$Position2D.position.y = rand_range(100.0, 500.0)
	if actual_mobs < 9:
		var mob = Enemy.instance()
		var mob_spawn_location = get_node("Spawn/PathFollow2D")
		mob_spawn_location.offset = randi()
		mob.position = mob_spawn_location.position
		mob.linear_velocity = ($Position2D.position - mob.position)
		$"List of enemies".add_child(mob)
		actual_mobs = get_child_count()
	else:
		actual_mobs = get_child_count()


func _on_Area2D_body_entered(_body):
	collided += 1


func _on_Button_pressed():
	for i in $"List of enemies".get_child_count():
		$"List of enemies".get_child(i).queue_free()
