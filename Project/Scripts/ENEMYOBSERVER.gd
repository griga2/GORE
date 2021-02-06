extends Node

var MobsChet4ik
var SpawnBank = 400
var PlayerSuccess
var firstStart=false

onready var shooterEnemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
onready var skyShotPrefab = load("res://Scenes/Enemys/SkyShoot.tscn")
onready var explosiveEnemyPrefab = load("res://Scenes/Enemys/Enemy_explosive.tscn")

#Eбучий костыль костыльный
#var EnemyList = [null, null]
var EnemyList = Array()

func _ready():
	pass

func SpawnMobs():
	pass


