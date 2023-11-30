extends Area2D
signal hit
signal howl
export (int) var speed = 300
var screen_size
var can_be_hit = true

func _ready():
	screen_size = get_viewport_rect().size
	#hide()
	
func _physics_process(delta):
	var velocity = Vector2.ZERO
	screen_size = get_viewport_rect().size
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h=false
		$AnimatedSprite.animation="Side"
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h=true
		$AnimatedSprite.animation="Side"
		velocity.x -= speed
	if Input.is_action_pressed("ui_up"):
		$AnimatedSprite.animation="Back"
		velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		$AnimatedSprite.animation="Front"
		velocity.y += speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	position += velocity * delta
	position.x = clamp(position.x, 35, screen_size.x-35)
	position.y = clamp(position.y, 30, screen_size.y-50)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(_body):
	if can_be_hit:
		emit_signal("hit")
		can_be_hit = false
		for i in 10:
			self.modulate.a = 0.5
			yield(get_tree().create_timer(0.1), "timeout")
			self.modulate.a = 1.0
			yield(get_tree().create_timer(0.1), "timeout")
		can_be_hit = true


func _input(event):
	if event.as_text()=="Z":
		dash()
	elif event.as_text()=="X":
		howl()

func dash():
	if Input.is_action_pressed("ui_right"):
		position.x += 50
	elif Input.is_action_pressed("ui_left"):
		position.x -= 50
	elif Input.is_action_pressed("ui_up"):
		position.y -= 50
	elif Input.is_action_pressed("ui_down"):
		position.y += 50

func howl():
	emit_signal("howl")
