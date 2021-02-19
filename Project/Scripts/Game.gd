extends Node2D

onready var shooterEnemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
onready var skyShotPrefab = load("res://Scenes/Enemys/SkyShoot.tscn")
onready var explosiveEnemyPrefab = load("res://Scenes/Enemys/Enemy_explosive.tscn")

func _ready():
	GLOBAL.PlayerHaveGun = true
	GLOBAL.PlayerPref.PlayerUpGun()
	pass


func _on_EnemyTimer_timeout():
	if GLOBAL.PlayerDead == false:
#		print("Timer finished")
		DebugSpawnMobs()
#		print (EENEMYOBSERVER.enemyPower)
	
func DebugSpawnMobs():
	if (EENEMYOBSERVER.enemyPower<=6000):
		for j in range(0,4):
#			add_child(AddExplosive())
#			add_child(AddShooter())
			add_child(AddLaser())

func AddExplosive():
	var rand = RandomNumberGenerator.new()
	var player = GLOBAL.PlayerPref
	var spawn_distance = 300
	var enemy = explosiveEnemyPrefab.instance()
	var x = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
	var y = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
	enemy.position.x = x
	enemy.position.y = y
	EENEMYOBSERVER.enemyPower+=150
	return enemy


func AddLaser():
	var rand = RandomNumberGenerator.new()
	var player = GLOBAL.PlayerPref
	var spawn_distance = 800
	var enemy = skyShotPrefab.instance()
	var x = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
	var y = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
	enemy.position.x = x
	enemy.position.y = y
	EENEMYOBSERVER.enemyPower+=50
	return enemy


func AddShooter():
	var rand = RandomNumberGenerator.new()
	var player = GLOBAL.PlayerPref
	var spawn_distance = 300
	var enemy = shooterEnemyPrefab.instance()
	var x = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
	var y = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
	enemy.position.x = x
	enemy.position.y = y
	EENEMYOBSERVER.enemyPower+=100
	return enemy


func _on_LasersTimer_timeout():
	pass
func _on_ExplosiveTimer_timeout():
	pass


