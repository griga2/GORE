extends Node2D
var BulletCount = 0
var firstShootWas = false
onready var gunTimer = $GunTimer
export (PackedScene) var bulletPref
var clicked = false

var screen_size 

func _process(delta):
	update()
func _ready():
	screen_size = get_viewport_rect().size

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
	if GLOBAL.PlayerDead == false && $Player.mazafakaDaash == false:
		var bullet = bulletPref.instance()
		add_child(bullet)
		bullet.global_position = $Player.current_hand.get_node("ShootPos").global_position
		bullet._activate()
#		$ShootSound.play()


func _draw():
	var Player = GLOBAL.PlayerPref
	draw_rect(Rect2(screen_size.x/2*-1+Player.position.x,screen_size.y/2*-1+Player.position.y, screen_size.x,75) , Color(100,100,100), 20, false)
	pass
