extends Node2D
onready var bulletPref = load("res://Scenes/Enemys/EBullet.tscn")
#var is_eaten = false
var dead = false
signal dead_for_array


func _on_GunTimer_timeout():
	if $EnemyShooter.ready == true:
		var bullet = bulletPref.instance()
		add_child(bullet)
		bullet.global_position = $EnemyShooter.current_hand.get_node("ShootPos").global_position
		bullet._activate()
		#$ShootSound.play()


func _on_AnimationPlayer_animation_finished(anim):
	if anim == "dead":
#		EENEMYOBSERVER.enemyPower-=100
		queue_free()


func Add_to_dead_group():
	add_to_group("Dead_enemy")
	dead=true

func Dead():
	return dead

func Eaten():
	pass
#	is_eaten = true
#	queue_free()
func AddPower() -> int:
	return 100


func AnimStarted(anim):
	if anim == "dead":
		emit_signal("dead_for_array", self)
		pass
