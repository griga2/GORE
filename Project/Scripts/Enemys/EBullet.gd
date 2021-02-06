extends KinematicBody2D
var speed = 800
var vector = Vector2(0,0)
var mouse_pos
onready var player_pos = GLOBAL.PlayerPref.global_position


func _ready():
#	_activate()
	pass

func _process(delta):
	move_and_slide(vector * speed)

func _on_TimerDie_timeout():
	queue_free()

func _activate():
	vector = player_pos - global_position
	vector = vector.normalized()
	look_at(player_pos)



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		#queue_free()
		pass
