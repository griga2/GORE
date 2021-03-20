extends AnimationPlayer


func _ready():
	pass



func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if (area.is_in_group("Player_bullet")):
		$Boss_crunch.BossCheck()


