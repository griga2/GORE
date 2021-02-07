extends Node2D
export (PackedScene) var bulletPref
#var is_eaten = false

var dead


func _on_AnimationPlayer_animation_finished(anim):
	if anim == "explosion":
		EENEMYOBSERVER.enemyPower-=150
		queue_free()


func Dead():
	return dead


func Eaten():
	pass
#	is_eaten = true
#	queue_free()

func GetType():
	return "Shooter"
