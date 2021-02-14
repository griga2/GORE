extends Node2D
var fps

func _input(event):
	if event.is_action_pressed("HideFps"):
		if $Control.visible == true:
			$Control.hide()
		elif $Control.visible == false:
			$Control.show()

func _process(delta):
	fps = Engine.get_frames_per_second()
	$Control/Counter.text = str(fps)
	pass
