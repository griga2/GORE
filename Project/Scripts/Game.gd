extends Node2D


onready var shooterEnemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
onready var skyShotPrefab = load("res://Scenes/Enemys/SkyShoot.tscn")
onready var explosiveEnemyPrefab = load("res://Scenes/Enemys/Enemy_explosive.tscn")

func _ready():
	GLOBAL.PlayerHaveGun = true
	GLOBAL.PlayerPref.PlayerUpGun()

	pass

var EnemyPowerNow = int(0)

func AddEnemyPower(value):
	EnemyPowerNow+=value

func _on_EnemyTimer_timeout():
	print("Timer finished")
	EENEMYOBSERVER.DebugSpawnMobs()


func _on_LasersTimer_timeout():
	pass
func _on_ExplosiveTimer_timeout():
	pass
