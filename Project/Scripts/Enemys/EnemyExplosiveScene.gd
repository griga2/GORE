extends Node2D
export (PackedScene) var bulletPref
#var is_eaten = false

var dead
signal dead_for_array

func _on_AnimationPlayer_animation_finished(anim):
	if anim == "explosion":
		emit_signal("dead_for_array")
		queue_free()


func Dead():
	return dead


func Eaten():
	pass
#	is_eaten = true
#	queue_free()

func AddPower() -> int:
	return 150
