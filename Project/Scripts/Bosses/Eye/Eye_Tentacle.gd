extends Node2D

func _process(delta):
	Z_index_manager()
	pass

func _ready():
	$Sprite.frame = 0
	$Sprite.flip_h = int(rand_range(0, 2))
	$AnimationPlayer.play("ready")


func Z_index_manager():
	if GLOBAL.PlayerPref.global_position.y < global_position.y:
		z_index = 0
	else: z_index = -2


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ready":
		$AnimationPlayer.play("moving")
	if anim_name == "dead":
		queue_free()


func _on_Bullet_Detect_area_entered(area):
	if area.is_in_group("Player_bullet"):
		$AnimationPlayer.play("dead")
		$Dead_Particles.global_rotation_degrees = area.global_rotation_degrees
		$Dead_Particles1.global_rotation_degrees = area.global_rotation_degrees
		$Dead_Particles2.global_rotation_degrees = area.global_rotation_degrees
	pass




