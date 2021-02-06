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
	DebugSpawnMobs()
	
func DebugSpawnMobs():
	for j in range(0,4):
		add_child(AddExplosive())
		add_child(AddShooter())
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
	return enemy


func AddLaser():
	var rand = RandomNumberGenerator.new()
	var player = GLOBAL.PlayerPref
	for i in range(0, 5): #GLOBAL.max_enemys
		var spawn_distance = 800
		var enemy = skyShotPrefab.instance()
		var x = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
		var y = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		enemy.position.x = x
		enemy.position.y = y
		return enemy


func AddShooter():
	var rand = RandomNumberGenerator.new()
	var player = GLOBAL.PlayerPref
	for i in range(0, GLOBAL.max_enemys): #GLOBAL.max_enemys
		var spawn_distance = 300
		var enemy = shooterEnemyPrefab.instance()
		var x = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
		var y = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		enemy.position.x = x
		enemy.position.y = y
		return enemy

func _on_LasersTimer_timeout():
	pass
func _on_ExplosiveTimer_timeout():
	pass


