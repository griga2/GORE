extends KinematicBody2D
var speed = 200 #Скорость вперёд
var backSpeed = -150 #Скорость назад
var move = true #Можно ли двигаться
var ready = false #Готов ли враг
var distance = int(rand_range(200, 370))#Рандомная дистанция до игрока
var nearPlayer = false #Рядом ли игрок
var hands_script = load("res://Scripts/Hand_Script.gd") #ссылка класс руки
var hands = hands_script.new()
onready var current_hand = $PBodyRight/PHand1 #Текущая рука
onready var player = GLOBAL.PlayerPref #Обращение к игрокку
var is_eaten = false
signal eaten #Испускается когда едят

func _ready():
	$PBodyLeft.scale.x = 0
	$PBodyLeft.scale.y = 0
	$PBodyRight.scale.x = 0
	$PBodyRight.scale.y = 0
	$AnimationPlayer.play("spawn")

func _process(delta):
	if ready == true:
		player = GLOBAL.PlayerPref
		Moving(delta)
		States()
		hands.Check_angle(player.global_position, current_hand.global_position, $HandPos.global_position)
		Hands_showing_and_rotate()
	pass

func States():
	if global_position.distance_to(player.global_position) > distance:
		move = true
		nearPlayer = false
	elif global_position.distance_to(player.global_position) < (distance-1):
		move = true
		nearPlayer = true
	else:
		move = false
		nearPlayer = false


func Moving(delta):
	if move == true:
		var MoveVec = player.global_position - global_position
		MoveVec = MoveVec.normalized()
		$AnimationPlayer.play("walk")
		if nearPlayer == false:
			move_and_slide(MoveVec * speed )
		elif nearPlayer == true:
			move_and_slide(MoveVec * backSpeed)
	else: $AnimationPlayer.play("stay")


func Hands_showing_and_rotate():
	current_hand.global_rotation = hands.look_angle_hand
	var h_s = hands
	h_s.body_is_right
	h_s.hand_is_up
	if h_s.body_is_right == true:
		if h_s.hand_is_up == true:
			$PBodyRight.show()
			$PBodyLeft.hide()
			$PBodyRight/PHand1.show()
			$PBodyRight/PHand2.hide()
			current_hand = $PBodyRight/PHand1
		if h_s.hand_is_up == false:
			$PBodyRight.show()
			$PBodyLeft.hide()
			$PBodyRight/PHand1.hide()
			$PBodyRight/PHand2.show()
			current_hand = $PBodyRight/PHand2
	elif h_s.body_is_right == false:
		if h_s.hand_is_up == true:
			$PBodyRight.hide()
			$PBodyLeft.show()
			$PBodyLeft/PHand1.show()
			$PBodyLeft/PHand2.hide()
			current_hand = $PBodyLeft/PHand1
		if h_s.hand_is_up == false:
			$PBodyRight.hide()
			$PBodyLeft.show()
			$PBodyLeft/PHand1.hide()
			$PBodyLeft/PHand2.show()
			current_hand = $PBodyLeft/PHand2
		pass

func _on_AnimationPlayer_animation_finished(anim):
	if anim == "spawn":
		ready = true
	


func _DetectArea_area_entered(area):
	if ready != false:
		if area.is_in_group("Player_bullet"):
			Dead(area)

func Dead(area):

	$AnimationPlayer.play("dead")
	$Dead_particles.rotation_degrees = area.global_rotation_degrees
	$Dead_Sprite.global_rotation_degrees = area.global_rotation_degrees + 45
	#$Dead_Particles.global_rotation_degrees = area.global_rotation_degrees
	var DeadSpeed = 10
	var DeadVec = area.vector
	var Demping = 0.1
	while DeadSpeed > 0:
		move_and_slide(DeadVec * DeadSpeed)
		DeadSpeed = DeadSpeed - Demping
	ready = false
	add_to_group("Dead_enemy")
	#emit_signal("add_to_dead_group")

func Eaten():
	is_eaten = true
	$Dead_Sprite.hide()
	$Eaten_particles.emitting = true
	emit_signal("eaten")
	
	

