extends Node2D

var dead = false

func _ready():
	$AnimPlayer.play("ready")

func AnimPlayer_finished(anim_name):
	if anim_name == "ready":
		$AnimPlayer.play("Shot")
	if anim_name == "Shot":
		$AnimPlayer.play("end")
	if anim_name == "end":
		dead=true
		queue_free()
		pass
func GetType():
	return "Laser"

func Dead():
	return dead

