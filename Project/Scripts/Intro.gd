extends Node2D
var FirstKill
var FirstEnemySpawned = false

func _ready():
	GLOBAL.PlayerHaveGun = false
	GLOBAL.PlayerPref.PlayerNoGun()
#	MUSIC.Play_music("Intro1")
#	MUSIC.Play_music("DoubleBass")
#	Enemy_spawn_first()

func Enemy_spawn_first():
	var rand = RandomNumberGenerator.new()
	var enemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
	var player = GLOBAL.PlayerPref
	
	
	for i in range(0, 1):
		#randomize()
		var spawn_distance = 200
		var enemy = enemyPrefab.instance()
		var x = player.global_position.x #+ rand_range(spawn_distance, -spawn_distance)
		var y = player.global_position.y + rand_range(-spawn_distance, -70)
		enemy.position.x = x
		enemy.position.y = y
		add_child(enemy)

func Enemy_spawn():
	var rand = RandomNumberGenerator.new()
	var enemyPrefab = load("res://Scenes/Enemys/Enemy_shooter.tscn")
	var player = GLOBAL.PlayerPref
	
	for i in range(0, 1):
		#randomize()
		var spawn_distance = 300
		var enemy = enemyPrefab.instance()
		var x = player.global_position.x + rand_range(spawn_distance, -spawn_distance)
		var y = player.global_position.y + rand_range(spawn_distance, -spawn_distance)
		enemy.position.x = x
		enemy.position.y = y
		add_child(enemy)


func Rhytm_timeout():
	pass
func BassRhytm_timeout():
#	MUSIC.Play_music("DoubleBass")
	if GLOBAL.PlayerHaveGun == true and FirstEnemySpawned == false:
		FirstEnemySpawned = true
#		Enemy_spawn_first()
	pass
