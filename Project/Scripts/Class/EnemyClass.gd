extends Node2D
class_name EnemyClass, "res://Recources/Enemy.png"

var Type
var TypeName
var positionX = 0
var positionY = 0
signal SignalDead(ID)

var EnemyID

func _ready():
	Type.connect("dead_for_array", self, "Dead")
	EnemyID = GLOBAL.EnemyID
	GLOBAL.EnemyID+=1

func _init(var _typeName, _obraz):
	Type= _obraz
	TypeName = _typeName
	CheakPosition()

onready var shooterEnemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
onready var laserEnemyPrefab = load("res://Scenes/Enemys/SkyShoot.tscn")
onready var explosiveEnemyPrefab = load("res://Scenes/Enemys/Enemy_explosive.tscn")

#func CheakPrefType():
#	match(TypeName):
#		"Shooter":
#			Type = shooterEnemyPrefab.instance()
#		"Laser":
#			Type = laserEnemyPrefab.instance()
#		"Explosive":
#			Type = explosiveEnemyPrefab.instance()
#		_:
#			print("In func EnemyClass.CheakPrefType not found enemy name")

func CheakPosition():
	var player = GLOBAL.PlayerPref
	var spawn_distance 
	match(TypeName):
		"Shooter":
			spawn_distance = 800
			positionX = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
			positionY = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		"Laser":
			spawn_distance = 500
			positionX = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
			positionY = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		"Explosive":
			spawn_distance = 500
			positionX = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
			positionY = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		_:
			print("In func EnemyClass.CheakPosition not found enemy name")
			spawn_distance = 500
			positionX = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
			positionY = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
	Type.position.x=positionX
	Type.position.y=positionY

func Dead():
	emit_signal("SignalDead", EnemyID)
	pass
