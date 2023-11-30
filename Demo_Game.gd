extends Node
export(PackedScene) var Enemy
export(PackedScene) var Beet

signal end

var actual_enemies = 0
var actual_beets = 0

var howl = true
var player_visible = true

func _ready():
	$Player.position = $"Start Position".position
	$Player.visible = true
	$"Enemy timer".start()
	$"Beet timer".start()
	randomize()

func _process(_delta):
	if $HUD/PowerCooldown.value == 100:
		howl = true
	else:
		howl = false

func _on_Beet_timer_timeout():
	if actual_beets < 5:
		var beet = Beet.instance()
		beet.z_index = -2
		beet.position.x = rand_range(100.0, 600.0)
		beet.position.y = rand_range(100.0, 350.0)
		beet.connect("hit", self, "collect_beet")
		$"Beet List".add_child(beet)
		actual_beets = $"Beet List".get_child_count()
	else:
		actual_beets = $"Beet List".get_child_count()

func collect_beet():
	$HUD.add_score()

func _on_Player_hit():
	$HUD.decrease_health()
	if $HUD.current_health <= 0:
		$Player.hide()
		$Player/CollisionShape2D.set_deferred("disabled", true)
		player_visible = false
		restart_mobs()
		$HUD.restart_hud()
		emit_signal("end")

func _on_Enemy_timer_timeout():
	if actual_enemies < 20:
		var enemy = Enemy.instance()
		var mob_pawn_location = get_node("Spawn Area/Spawn")
		mob_pawn_location.offset = randi()
		enemy.position = mob_pawn_location.position
		enemy.z_index = -2
		enemy.linear_velocity = ($Player.position - enemy.position)
		$"Enemy List".add_child(enemy)
		actual_enemies = $"Enemy List".get_child_count()
	else:
		actual_enemies = $"Enemy List".get_child_count()

func _on_Player_howl():
	if howl and player_visible:
		for i in $"Enemy List".get_child_count():
			$"Enemy List".get_child(i).queue_free()
		$HUD/PowerCooldown.reinit()
		
func restart_mobs():
	$"Beet timer".stop()
	$"Enemy timer".stop()
	for i in $"Enemy List".get_child_count():
			$"Enemy List".get_child(i).queue_free()
	for i in $"Beet List".get_child_count():
		$"Beet List".get_child(i).queue_free()
