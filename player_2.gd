class_name Player extends CharacterBody2D

var move_speed:float = 100.0
var facing_h = Vector2.RIGHT
var facing_v = Vector2.DOWN
var state = "idle"

func _ready():
	pass
	
func _process(delta):
	var direction:Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = direction * move_speed
	position += velocity * delta
	
	pass

#func _physics_process(delta):
	#move_and_slide()
