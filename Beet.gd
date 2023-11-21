extends Area2D
signal hit

func _ready():
	$AnimatedSprite.play("Spawn")

func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = false
	$AnimatedSprite.play("Idle")

func _on_Beet_area_entered(_area):
	emit_signal("hit")
	queue_free()
