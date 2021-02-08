extends Node2D

var MaxPowerBank = 1500

onready var shooterEnemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
onready var skyShotPrefab = load("res://Scenes/Enemys/SkyShoot.tscn")
onready var explosiveEnemyPrefab = load("res://Scenes/Enemys/Enemy_explosive.tscn")

func _ready():
	GLOBAL.PlayerHaveGun = true
	GLOBAL.PlayerPref.PlayerUpGun()
	pass


func _on_EnemyTimer_timeout():
	print("EnemyTimer finished")
	DebugSpawnMobs()
	print ("Enemy powerPower = ",EENEMYOBSERVER.enemyPower)
	
func DebugSpawnMobs():
	CheakDefanceLevel(NeedAddNewMob())
	if (EENEMYOBSERVER.enemyPower<=6000):
		for j in range(0,4):
			add_child(AddExplosive())
			add_child(AddShooter())
			add_child(AddLaser())

func NeedAddNewMob() -> String:
	var Metka = String("Func not work")
	var PowerNow = 0
	for enemy in get_tree().get_nodes_in_group("enemys"):
		PowerNow+=enemy.AddPower()
	if(MaxPowerBank/4 >= PowerNow):
		Metka = "More mobs"
	elif(MaxPowerBank/4 < PowerNow && MaxPowerBank/4*3 >= PowerNow):
		Metka = "A few mobs"
	elif(MaxPowerBank/4*3 < PowerNow):
		Metka = "A less mobs"
	if (Metka == "" || Metka == "Func not work"):
		print ("Function NeedAddNewMob is not working correct")
	return Metka

func CheakDefanceLevel(var NeedSpawnValue ):
	print ("Function need spawn return ", NeedSpawnValue)
	var PowerOnStartFunction = MaxPowerBank
	var HowWasAdd = 0
	match NeedSpawnValue:
		"More mobs":
			HowWasAdd = randi()%100+200
			MaxPowerBank += HowWasAdd
			print ("In function CheakDefenceLavel using block More mobs,", HowWasAdd, " was add on MaxPowerBank")
		"A few mobs":
			HowWasAdd = randi()%50+50
			MaxPowerBank += HowWasAdd
			print ("In function CheakDefenceLavel using block A few mobs,", HowWasAdd, " was add on MaxPowerBank")
		"A less mobs":
			HowWasAdd = randi()%50+50
			MaxPowerBank -= HowWasAdd
			print ("In function CheakDefenceLavel using block A less mobs,", HowWasAdd, " was add on MaxPowerBank")
		_:
			print ("In function CheakDefenceLavel somethink break, match use defalt block")
		
	
	pass

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
	enemy.add_to_group("enemys")
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
	enemy.add_to_group("enemys")
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
	enemy.add_to_group("enemys")
	return enemy


func _on_LasersTimer_timeout():
	pass
func _on_ExplosiveTimer_timeout():
	pass


