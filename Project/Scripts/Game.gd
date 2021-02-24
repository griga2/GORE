extends Node2D

var MaxPowerBank = 1500
var NeedSpawnShooter = 4
var NeedSpawnExplosive = 3
var NeedSpawnLaser = 5

var EnemyList: Array
var EnemyListToSpawnNow: Array

onready var shooterEnemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
onready var laserEnemyPrefab = load("res://Scenes/Enemys/SkyShoot.tscn")
onready var explosiveEnemyPrefab = load("res://Scenes/Enemys/Enemy_explosive.tscn")


func _ready():
	GLOBAL.PlayerHaveGun = true
	GLOBAL.PlayerPref.PlayerUpGun()
	pass


func _on_EnemyTimer_timeout():
	AddRandomMobs()
	DebugSpawnMobs()
	for enemy in EnemyListToSpawnNow:
		EnemyList.append(enemy)
		add_child(enemy.Type)
	EnemyListToSpawnNow.clear()
	
func DebugSpawnMobs():
	SpawnMobsUnitarFunc("Shooter")
	SpawnMobsUnitarFunc("Laser")
	SpawnMobsUnitarFunc("Explosive")

func SpawnMobsUnitarFunc(var Name):
	var enemy
	match(Name):

		"Shooter":
			enemy = EnemyClass.new("Shooter",shooterEnemyPrefab.instance())
			enemy.connect("SignalDead", self, "DeliteEnemy")
		"Laser":
			enemy = EnemyClass.new("Laser",laserEnemyPrefab.instance())
			enemy.connect("SignalDead", self, "DeliteEnemy")
		"Explosive":
			enemy = EnemyClass.new("Explosive",shooterEnemyPrefab.instance())
			enemy.connect("SignalDead", self, "DeliteEnemy")
		_:
			pass
	EnemyListToSpawnNow.append(enemy)

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
			print ("In function CheakDefenceLavel using block More mobs,", HowWasAdd, " was add on MaxPowerBank")
		"A few mobs":
			print ("In function CheakDefenceLavel using block A few mobs,", HowWasAdd, " was add on MaxPowerBank")
		"A less mobs":
			print ("In function CheakDefenceLavel using block A less mobs,", HowWasAdd, " was add on MaxPowerBank")
		_:
			print ("In function CheakDefenceLavel somethink break, match use defalt block")
	pass

func AddRandomMobs():
	var rand = randi()%2+1
	match rand:
		1:
			EnemyListToSpawnNow.append(EnemyClass.new("Shooter", shooterEnemyPrefab.instance()))
		2:
			EnemyListToSpawnNow.append(EnemyClass.new("Explosiver", explosiveEnemyPrefab.instance()))
		3:
			EnemyListToSpawnNow.append(EnemyClass.new("Laser", laserEnemyPrefab.instance()))
		_:
			pass
	pass


func _on_LasersTimer_timeout():
	var enemy = shooterEnemyPrefab
	add_child(enemy.instance())
	enemy.connect("dead_for_array", self, "EnemyIsDead")

func _on_ExplosiveTimer_timeout():
	pass

func DeliteEnemy(ID):
	
	var metkaDeliteEnemy = 0
	
	for enemy in EnemyList:
		if(enemy.EnemyID!=ID):
			metkaDeliteEnemy+=1
		else:
			break
	EnemyList.remove(metkaDeliteEnemy)
#	var metka = 0
#	for enemy in EnemyList:
#		if(enemy.has_method("GetDead")):
#			EnemyList.remove(metka)
#		else:
#			pass
#		metka+=1
	pass
	
func EnemyIsDead(enemy):
	print("enemyolo")
	pass
