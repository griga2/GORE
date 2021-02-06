extends Camera2D

var pointOnPlayer = true

func _input(event):
	if event.is_action_pressed("StopCamera"):
		if pointOnPlayer == true:
			pointOnPlayer = false
			return
		elif pointOnPlayer == false:
			pointOnPlayer = true
			return
	pass

func _process(delta):
	if pointOnPlayer == true:
		global_position = GLOBAL.PlayerPref.global_position
	pass

