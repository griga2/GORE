extends Node2D



func _ready():
	$AnimationPlayer.play("shot endless V3")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass

func _process(delta):
	global_position = get_global_mouse_position()
	GLOBAL.mousPos = $ComePos

func _play_animation():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("shot V2")
