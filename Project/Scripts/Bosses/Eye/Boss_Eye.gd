extends Node2D
onready var bullet = load("res://Scenes/Bosses/Eye/Eye_Bullet.tscn")

func Bullet_attac():
	$BodyAnim.play("Bullets_attac_1")
	Spawn_Bullets()

func Spawn_Bullets():
	var rotation = -45
	for h in 8:
		rotation += 45
#		print(h)
#		print("Bullet_points/Position" + str(h))
		var shot_bultet = bullet.instance()
		add_child(shot_bultet)
		shot_bultet.global_position = get_node("Bullet_points/Position" + str(h)).global_position
		shot_bultet.rotation_degrees = rotation
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Bullets_attac_1":
		$BodyAnim.play("Stay")
		
