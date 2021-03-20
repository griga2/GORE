extends Camera2D
const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT
onready var camera = self
var shakeAmplitude = 0
var priority
var pointOnPlayer = true

#-------ТРЯСКА КАМЕРЫ------------
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
	
	$Tween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$Tween.start()

func reset():
	$Tween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$Tween.start()


func _on_Frequency_timeout():
	new_shake()

func _on_Duration_timeout():
	reset()
	$Frequency.stop()


#-------ДЕШ КАМЕРЫ--------
func Camera_dash(vector = Vector2()):
	if pointOnPlayer == true:
		var amplitude = -100
		var time = 1
		$DashTimer.start()
		
		vector = vector.normalized() * amplitude
		$Tween.interpolate_property(self, "offset", camera.offset, vector, time, Tween.TRANS_QUART, Tween.EASE_OUT)
		$Tween.start()
		pass

func _on_DashTimer_timeout():
	$Tween.interpolate_property(camera, "offset", camera.offset, Vector2(), 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()



#--------СЛЕЖЕНИЕ ЗА ИГРОКОМ-----


func _input(event):
	if event.is_action_pressed("StopCamera"):
		if pointOnPlayer == true:
			pointOnPlayer = false
			return
		elif pointOnPlayer == false:
			pointOnPlayer = true
			return
#	if event.is_action_pressed("dash"):
#		Camera_dash()
	pass

func _process(delta):
	if pointOnPlayer == true:
		global_position = GLOBAL.PlayerPref.global_position
	pass
