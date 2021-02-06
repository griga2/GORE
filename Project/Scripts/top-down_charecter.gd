extends KinematicBody2D

var MOVE_SPEED = 300

func _physics_process(delta):
	Moving(delta)
	Mouse_looking()

func Moving(delta):
	var move_vect = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vect.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vect.y += 1
	if Input.is_action_pressed("move_right"):
		move_vect.x += 1
	if Input.is_action_pressed("move_left"):
		move_vect.x -= 1
	move_vect = move_vect.normalized()
	move_and_collide(move_vect * MOVE_SPEED * delta)

func Mouse_looking():
	var look_vec = get_global_mouse_position() - global_position
	$PBdy/PHand1.global_rotation = atan2(look_vec.y, look_vec.x)



