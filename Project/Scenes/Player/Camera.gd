extends Camera2D
#-------ТРЯСКА КАМЕРЫ------------
const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT
onready var camera = self
var shakeAmplitude = 0

func start(duration = 0.2, frequency = 15, amplitude = 16):
	self.shakeAmplitude = amplitude
	
	$Duration.wait_time = duration
	$Frequency.wait_time = 1 / float(frequency)
	$Duration.start()
	$Frequency.start()
	
	new_shake()

func new_shake():
	var rand = Vector2()
	rand.x = rand_range(-shakeAmplitude, shakeAmplitude)
	rand.y = rand_range(-shakeAmplitude, shakeAmplitude)
	
	$Shake_Tween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$Shake_Tween.start()

func reset():
	$Shake_Tween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$Shake_Tween.start()

func _on_Frequency_timeout():
	new_shake()

func _on_Duration_timeout():
	reset()
	$Frequency.stop()

#--------СЛЕЖЕНИЕ ЗА ИГРОКОМ-----
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







