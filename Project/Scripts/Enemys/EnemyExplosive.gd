extends KinematicBody2D
var speed = 200 #Скорость вперёд
var backSpeed = -150 #Скорость назад
var move = true #Можно ли двигаться
var ready = false #Готов ли враг
var distance = 40#дистанция до игрока
var nearPlayer = false #Рядом ли игрокvar
onready var player = GLOBAL.PlayerPref #Обращение к игрокку
var explode = false #Взорвлася ли?

func _ready():
	$Body.scale.x = 0
	$Body.scale.y = 0
	$AnimationPlayer.play("spawn")

func _process(delta):
	if ready == true:
		player = GLOBAL.PlayerPref
		Moving(delta)
		States()
	pass

func States():
	if global_position.distance_to(player.global_position) > distance && nearPlayer == false && explode == false:
		move = true
	elif explode == false:
		move = false
		nearPlayer = true
		$AnimationPlayer.play("ticking")

func Moving(delta):
	if move == true:
		var MoveVec = player.global_position - global_position
		MoveVec = MoveVec.normalized()
		$AnimationPlayer.play("walk")
		if nearPlayer == false:
			move_and_slide(MoveVec * speed )
#	else: $AnimationPlayer.play("stay")

func _on_AnimationPlayer_animation_finished(anim):
	if anim == "spawn":
		ready = true
	if anim == "ticking":
		Explode()
	if anim == "explosion":
		queue_free()

func Explode():
	explode = true
	move = false
	nearPlayer = true
	$AnimationPlayer.stop()
	$Body.hide()
	$AnimationPlayer.play("explosion")
	pass

func _DetectArea_area_entered(area):
	if ready != false:
		if area.is_in_group("Player_bullet") and explode == false:
			Explode()

func Dead(area):
	$AnimationPlayer.play("dead")
	$Dead_particles.rotation_degrees = area.global_rotation_degrees
	$Dead_Sprite.global_rotation_degrees = area.global_rotation_degrees + 45
	var DeadSpeed = 10
	var DeadVec = area.vector
	var Demping = 0.1
	while DeadSpeed > 0:
		move_and_slide(DeadVec * DeadSpeed)
		DeadSpeed = DeadSpeed - Demping
	ready = false
	add_to_group("Dead_enemy")
	#emit_signal("add_to_dead_group")
func GetType():
	return "Explosive"
