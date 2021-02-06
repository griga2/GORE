extends Node2D

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Game.tscn")

func _ready():
	$AnimationPlayer.play("ready")
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("main")
