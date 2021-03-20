extends Node2D
var BulletCount = 0
var firstShootWas = false
onready var gunTimer = $GunTimer
export (PackedScene) var bulletPref
var clicked = false



func _input(event):
	if event.is_action_pressed("shoot"):
		PutDown()
	if event.is_action_released("shoot"):
		PutUp()

func PutDown():
	clicked = true
	if GLOBAL.Shooting == false:
		Start_Gun_Timer()

func PutUp():
	clicked = false

func Gun_Timer_finished():
	if clicked == true:
		Start_Gun_Timer()
	else:
		GLOBAL.Shooting = false

func Start_Gun_Timer():
	gunTimer.start()
	GLOBAL.Shooting = true
	Spawn_Bullet()
	pass

func Spawn_Bullet():
	if GLOBAL.PlayerDead == false && $Player.mazafakaDaash == false && GLOBAL.PlayerHaveGun == true:
		var bullet = bulletPref.instance()
		add_child(bullet)
		bullet.global_position = $Player.current_hand.get_node("ShootPos").global_position
		bullet._activate()
		$ShootSound.play()

