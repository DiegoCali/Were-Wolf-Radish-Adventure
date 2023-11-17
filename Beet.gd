extends Area2D

func _ready():
	$AnimatedSprite.play("Spawn")

func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = false
	$AnimatedSprite.play("Idle")

func _on_Beet_area_entered(_area):
	queue_free()
