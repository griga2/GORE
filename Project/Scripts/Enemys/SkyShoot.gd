extends Node2D



func _ready():
	$AnimPlayer.play("ready")

func AnimPlayer_finished(anim_name):
	if anim_name == "ready":
		$AnimPlayer.play("Shot")
	if anim_name == "Shot":
		$AnimPlayer.play("end")
	if anim_name == "end":
		EENEMYOBSERVER.enemyPower-=50
		queue_free()

func AddPower() -> int:
	return 50

