extends "res://Scripts/Class/EnemyClass.gd"
class_name Shooter, "res://Recources/Shooter.png"

var spawn_distance = 300

func _init(var type):
	var x = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
	var y = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
	.init(type, x, y)

var player = GLOBAL.PlayerPref

func _ready():
	pass
