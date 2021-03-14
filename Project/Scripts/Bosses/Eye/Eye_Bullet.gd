extends Node2D
var is_ready = false

func _process(delta):
	if is_ready == true:
		position += transform.y * -600 * delta

func _ready():
	$AnimationPlayer.play("ready")




func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ready":
		is_ready = true
