extends Node2D

var DefficaltysiveLevel = 1

var MaxPowerBank = DefficaltysiveLevel * (50*2 + 100*2 + 150)

var NeedSpawnShooter = 4
var NeedSpawnExplosive = 3
var NeedSpawnLaser = 5
var NeedSpawnRandomMobs: int = 0 

var PowerNow = 0

var MetkaFromRestartSpawnAfterPereriv: bool = false

var oaoaommmo
var HowWaveWasSpawn = 0 
var WaveKolv = 5

var EnemyList: Array
var EnemyListToSpawnNow: Array

onready var shooterEnemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
onready var laserEnemyPrefab = load("res://Scenes/Enemys/SkyShoot.tscn")
onready var explosiveEnemyPrefab = load("res://Scenes/Enemys/Enemy_explosive.tscn")

func _ready():
	GLOBAL.PlayerHaveGun = true
	GLOBAL.PlayerPref.PlayerUpGun()
	DebugSpawnMobs()
	pass

func _on_EnemyTimer_timeout():
	CheakFromPereriv()
	
	SpawnDefoltPackMibs()
	AddRandomMobs()
	
	for enemy in EnemyListToSpawnNow:
		EnemyList.append(enemy)
		add_child(enemy.Type)
		PowerNow+=enemy.Type.AddPower()
		
	NeedAddNewMob()
	
	EnemyListToSpawnNow.clear()
	
	HowWaveWasSpawn+=1
	print("HowWaveWasSpawn =", HowWaveWasSpawn)
	
	if (MetkaFromRestartSpawnAfterPereriv==true):
		$EnemyTimer.wait_time=1.5
		MetkaFromRestartSpawnAfterPereriv=false
	
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

	if(MaxPowerBank/4 >= PowerNow):
		Metka = "More mobs"
	elif(MaxPowerBank/4 < PowerNow && MaxPowerBank/4*3 >= PowerNow):
		Metka = "A few mobs"
	elif(MaxPowerBank/4*3 < PowerNow):
		Metka = "A less mobs"
	if (Metka == "" || Metka == "Func not work"):
		print ("Function NeedAddNewMob is not working correct")
	PowerNow=0
	return Metka

func CheakDefanceLevel(var NeedSpawnValue ):
	print ("Function need spawn return ", NeedSpawnValue)
	var PowerOnStartFunction = MaxPowerBank
	var HowWasAdd = 0
	match NeedSpawnValue:
		"More mobs":
			HowWasAdd=randi()%4+2
			print ("In function CheakDefenceLavel using block More mobs,", HowWasAdd, " was add on MaxPowerBank")
		"A few mobs":
			HowWasAdd=randi()%2+1
			print ("In function CheakDefenceLavel using block A few mobs,", HowWasAdd, " was add on MaxPowerBank")
		"A less mobs":
			print ("In function CheakDefenceLavel using block A less mobs,", HowWasAdd, " was add on MaxPowerBank")
			if(HowWasAdd>0):HowWasAdd-=1
		_:
			print ("In function CheakDefenceLavel somethink break, match use defalt block")
	pass

func AddRandomMobs():
	for i in range(NeedSpawnRandomMobs):
		var rand = randi()%2+1
		match rand:
			1:
				EnemyListToSpawnNow.append(EnemyClass.new("Shooter", shooterEnemyPrefab.instance()))
			2:
				EnemyListToSpawnNow.append(EnemyClass.new("Explosive", explosiveEnemyPrefab.instance()))
			3:
				EnemyListToSpawnNow.append(EnemyClass.new("Laser", laserEnemyPrefab.instance()))
			_:
				pass
	pass

func DeliteEnemy(ID):
	var metkaDeliteEnemy = 0	
	for enemy in EnemyList:
		if(enemy.EnemyID!=ID):
			metkaDeliteEnemy+=1
		else:
			break
	EnemyList.remove(metkaDeliteEnemy)
	pass

func _on_DiffinsivTimer_timeout():
	
	pass
	
func CheakFromPereriv():
	if (HowWaveWasSpawn>=WaveKolv):
		$EnemyTimer.wait_time=30
		print("func CheakFromPereriv good finished")
		HowWaveWasSpawn=0
		MetkaFromRestartSpawnAfterPereriv=true
	pass

func SpawnDefoltPackMibs():
	SpawnMobsUnitarFunc("Shooter")
	SpawnMobsUnitarFunc("Laser")
	SpawnMobsUnitarFunc("Explosive")
