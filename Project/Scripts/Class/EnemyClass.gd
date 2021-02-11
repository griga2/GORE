extends Node2D
class_name EnemyClass, "res://Recources/Enemy.png"

var Type
var TypeName
var positionX
var positionY

func _init(var typeName):
	TypeName = typeName
	CheakPrefType()
	CheakPosition(TypeName)

onready var shooterEnemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
onready var laserEnemyPrefab = load("res://Scenes/Enemys/SkyShoot.tscn")
onready var explosiveEnemyPrefab = load("res://Scenes/Enemys/Enemy_explosive.tscn")

func _ready():
	pass

func CheakPrefType():
	match(TypeName):
		"Shooter":
			Type = shooterEnemyPrefab.instance()
		"Laser":
			Type = laserEnemyPrefab.instance()
		"Explosive":
			Type = explosiveEnemyPrefab.instance()
		_:
			print("In func EnemyClass.CheakPrefType not found enemy name")

func CheakPosition(var type: String):
	var player = GLOBAL.PlayerPref
	var spawn_distance 
	match(TypeName):
		"Shooter":
			spawn_distance = 800
			positionX = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
			positionY = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		"Laser":
			spawn_distance = 600
			positionX = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
			positionY = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		"Explosive":
			spawn_distance = 400
			positionX = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
			positionY = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		_:
			print("In func EnemyClass.CheakPosition not found enemy name")

