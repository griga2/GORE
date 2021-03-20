extends Node2D
onready var bullet_pref = load("res://Scenes/Bosses/Eye/Eye_Bullet.tscn")
onready var mini_bullet_pref = load("res://Scenes/Bosses/Eye/Eye_MiniBullet.tscn")
onready var tentacle_pref = load("res://Scenes/Bosses/Eye/Eye_Tentacle.tscn")

func _process(delta):
	Z_index_manager()
	pass

func Rotate_Bul_pos():
	$Bullet_points.rotation_degrees += 12

func Attack_Bullet():
	$BodyAnim.play("Attack_1")
	Spawn_Bullets()

func Spawn_Bullets():
	var rotation = -45
	for h in 8:
		rotation += 45
		var shot_bultet = bullet_pref.instance()
		add_child(shot_bultet)
		shot_bultet.global_position = get_node("Bullet_points/Position" + str(h)).global_position
		shot_bultet.rotation_degrees = rotation
	pass

func Spawn_Mini_Bullets():
	var rotation = -12 #-18
	for h in 30: #20
		rotation += 12
		var shot_mini_bultet = mini_bullet_pref.instance()
		add_child(shot_mini_bultet)
		shot_mini_bultet.global_position = $Bullet_points.global_position
		shot_mini_bultet.rotation_degrees = rotation
	pass

func Spawn_Tentacles():
	var count_tentacle = 30
	var min_distance = 10
	var distance = 700
	
	for h in count_tentacle:
		var player_pos = GLOBAL.PlayerPref.global_position
		var tentacle = tentacle_pref.instance()
		var x = int(rand_range(-distance, distance))
		var y = int(rand_range(-distance, distance))
		add_child(tentacle)
		tentacle.global_position.x = player_pos.x + x
		tentacle.global_position.y = player_pos.y + y
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack_1":
#		Spawn_Mini_Bullets()
		$BodyAnim.play("Stay")

func Z_index_manager():
	if GLOBAL.PlayerPref.global_position.y -80 < global_position.y:
		$Enemy_Eye.z_index = 1
	else: $Enemy_Eye.z_index = -1
#	if GLOBAL.PlayerPref.global_position.y -80 < global_position.y:
#		$Enemy_Eye.z_index = 3
#	else: $Enemy_Eye.z_index = 1


func Attac_Tentacle():
	$BodyAnim.play("Attack_1")
	Spawn_Tentacles()
