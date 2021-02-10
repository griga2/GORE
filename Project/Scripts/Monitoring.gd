extends Node2D
var fps

func _process(delta):
	fps = Engine.get_frames_per_second()
	$Control/Counter.text = str(fps)
	pass
