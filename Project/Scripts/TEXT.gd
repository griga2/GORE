extends Node
onready var Text = $Text
onready var TButton = $Text/TButton



func Show_text(text = "TEXT", button = "", hideIt = true):
	Text.text = text
	TButton.text = button
	if hideIt == true:
		$TextAnim.play("Show and hide")
	else:
		$TextAnim.play("Show")

func Hide_text():
	#$BGcollor.hide()
	Text.hide()


