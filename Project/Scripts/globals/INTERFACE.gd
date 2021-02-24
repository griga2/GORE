extends CanvasLayer
var fps
onready var Text = $TEXT/Text
onready var TButton = $TEXT/Text/TButton
onready var TAnimator = $TEXT/TextAnim



func Show_text(text = "TEXT", button = "", hideIt = true):
	Text.text = text
	TButton.text = button
	if hideIt == true:
		TAnimator.play("Show and hide")
	else:
		TAnimator.play("Show")

func Hide_text():
	Text.hide()

func _input(event):
	if event.is_action_pressed("HideFps"):
		if $MONITORING.visible == true:
			$MONITORING.hide()
		elif $MONITORING.visible == false:
			$MONITORING.show()

func _process(delta):
	fps = Engine.get_frames_per_second()
	$MONITORING/Counter.text = str(fps)
	pass
