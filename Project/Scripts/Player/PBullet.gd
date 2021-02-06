extends KinematicBody2D
var speed = 1000
var vector = Vector2(0,0)
var mouse_pos


func _ready():
#	_activate()
	pass

func _process(delta):
	$DetectArea.vector = vector
	move_and_slide(vector * speed)

func _on_TimerDie_timeout():
	queue_free()

func _activate():
	vector = get_global_mouse_position() - global_position
	vector = vector.normalized()
	look_at(get_global_mouse_position())

