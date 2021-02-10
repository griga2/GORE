extends Node2D
onready var bulletPref = load("res://Scenes/Enemys/EBullet.tscn")
#var is_eaten = false
var dead = false
var GunTime

func _ready():
	RandShootTime()
	pass

func _on_GunTimer_timeout():
	if $EnemyShooter.ready == true and GLOBAL.PlayerDead == false:
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

func GetType():
	return "Shooter"

func RandShootTime():
	GunTime = rand_range(0.4, 1)
	GunTime = stepify(GunTime, 0.1)
	$GunTimer.wait_time = GunTime
