extends Area2D
signal hit

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	#hide()

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	# Replace your current animation logic with this:
	if velocity.length() > 0:
		# Prioritize vertical movement first, then horizontal
		if velocity.y > 0:  # Moving down (towards camera)
			if velocity.x > 0:
				$AnimatedSprite2D.animation = "walk_right"  # Down-right
			elif velocity.x < 0:
				$AnimatedSprite2D.animation = "walk_left"   # Down-left
			else:
				$AnimatedSprite2D.animation = "walk_right"  # Pure down (choose default)
		elif velocity.y < 0:  # Moving up (away from camera)
			if velocity.x > 0:
				$AnimatedSprite2D.animation = "walk_up_right"  # Up-right
			elif velocity.x < 0:
				$AnimatedSprite2D.animation = "walk_up_left"   # Up-left
			else:
				$AnimatedSprite2D.animation = "walk_up_right"  # Pure up (choose default)
		else:  # Pure horizontal movement (velocity.y == 0)
			if velocity.x > 0:
				$AnimatedSprite2D.animation = "walk_right"
			else:  # velocity.x < 0
				$AnimatedSprite2D.animation = "walk_left"


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
