extends Node
var mousPos
var PlayerPref
var max_enemys = 5
var PlayerHP = 100
var PlayerHaveGun = false
var PlayerDead = true
var Shooting = false 
var ChektchikNotBulletHell = 0 

var EnemyID = 0

func _input(event):
	if event.is_action_released("restart") :#and PlayerHP == 0
		get_tree().reload_current_scene()
		INTERFACE.Hide_text()
		PlayerHP = 100
		Shooting = false 
	if event.is_action_released("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("eat") or ( event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT):
		CheakDistansToDaedEnemy()

func _ready():
	randomize()
	pass

func CheakDistansToDaedEnemy():
	var DeadEnemys = get_tree().get_nodes_in_group("Dead_enemy")
	for i in range(0, DeadEnemys.size()):
		if CheakDistant(DeadEnemys[i].global_position, PlayerPref.global_position) <=80:
			EatEnemy(DeadEnemys[i])

func CheakDistant(EnemyCaord, PlayerCaord):
#	return 10
	return PlayerCaord.distance_to(EnemyCaord)

func EatEnemy(DeadEnemy):
	if DeadEnemy.is_eaten == false and PlayerHP < 100 and PlayerHP > 0:
		PlayerHP +=30
		PlayerPref.Eat()
		DeadEnemy.Eaten()
	

